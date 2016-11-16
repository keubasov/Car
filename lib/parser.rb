module Par
  class Parser

    require 'nokogiri'
    require 'open-uri'

    #Парсит информацияю об авто, сохраняет свежие объявления и сразу отправляет на рассылку,
    # если есть подходящие подписчики
    def self.parse_cars
      Thread.new do
        while true do
          (3..6).each do |page_num|
            source= "http://auto.drom.ru/all/page#{page_num}/"
            page= Nokogiri::HTML(open source)
            trs = page.css('tr[data-bull-id]')
            trs.each do |tr|
              #'закрепленные' объявления игнорируем
              next if  tr['data-is-sticky']=='1'
              tds = tr.css('td')
              link=tds[0].css('a')[0]['href']
              name=tds[2].text.strip.split(' ',3)
              #идентификатор объявления на сайте
              site_id=tr['data-bull-id'].to_i
              #избегаем дублирования объявлений в БД
              unless Ad.find_by_site_id site_id
                date = tds[0].text.to_date
                make= name[0]
                model=name[1]
                year=tds[2].text.scan(/\d+/)[0].to_i
                price=tds[6].text.delete(' ').scan(/\d+/)[0].to_i
                region = Region.find_by_town_name(tds[6].css('span')[1].text)
                next if region.nil?
                ad=Ad.new(date: date,
                            make: make,
                            model: model,
                            year: year,
                            price: price,
                            link: link,
                            site_id: site_id,
                            region_id: region.id)
                if ad.save
                  search_overlap ad
                end   #if
              end #unless
            end #each trs
          end  #each page_num
          sleep 10
        end   #loop
      end   #Thread
    end

    #Выбирает пользователей, подписки которых совпадают с найденым автомобилем и
    # отправляет их список, вместе с самим объявлением в telegram
    def self.search_overlap (ad)

      users_ids = Subscription.users_to_sub(ad)
      unless users_ids.blank?
        Tel_bot.push ({a: ad, ids: users_ids})
      end
    end


  end
end
