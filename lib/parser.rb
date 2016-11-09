module Par
  class Parser

    require 'nokogiri'
    require 'open-uri'

    def self.parse_cars
      Thread.new do
        while true do
          (2..6).each do |page_num|
            source= "http://omsk.drom.ru/auto/all/page#{page_num}/"
            page= Nokogiri::HTML(open source)
            trs=page.css('table')[2].css('tr.row')
            trs.each do |tr|
              next if  tr['data-is-sticky']=='1'
              tds = tr.css('td')
              link=tds[0].css('a')[0]['href']
              name=tds[2].text.strip.split(' ',3)
              site_id=tr['data-bull-id'].to_i
              unless Ad.find_by_site_id site_id
                date = tds[0].text.to_date
                make= name[0]
                model=name[1]
                year=tds[2].text.scan(/\d+/)[0].to_i
                price=tds[6].text.delete(' ').scan(/\d+/)[0].to_i
                ad=Ad.new(date: date,
                            make: make,
                            model: model,
                            year: year,
                            price: price,
                            link: link,
                            site_id: site_id)
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

    #        Выбирает пользователей, подписки которых совпадают с найденым автомобилем и
    def self.search_overlap (ad)
      type = Type.find_by_name(ad.model)
      return if type.nil?
      type_id = type.id
      subs = Subscription.where( "type_id IN (?, ?) AND max_price >= ? AND min_year <= ?", type_id, 0, ad.price, ad.year)
      unless subs.blank?
        users=subs.pluck(:user_id).uniq
        if users && !users.empty?
          Tel_bot.push ({a: ad, u: users})
        end
      end
    end


  end
end
