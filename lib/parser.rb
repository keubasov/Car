class Parser

  require 'nokogiri'
  require 'open-uri'

  #Парсит информацияю об авто, сохраняет свежие объявления и сразу отправляет на рассылку,
  # если есть подходящие подписчики
  def parse_cars(mes_queue)
    (3..6).each do |page_num|
      source= "http://auto.drom.ru/all/page#{page_num}/"
      page= Nokogiri::HTML(open source)
      trs = page.css('tr[data-bull-id]')
      trs.each do |tr|
        #'закрепленные' объявления игнорируем
        next if  tr['data-is-sticky']=='1'
        ad = parse_tr tr
        next unless ad
        if ad.save
          search_overlap ad, mes_queue
        end   #if
      end #each trs
    end  #each page_num
  end

  #Выбирает пользователей, подписки которых совпадают с найденым автомобилем и
  # отправляет их список, вместе с самим объявлением в telegram
  def search_overlap (ad, mes_queue)
    users_ids = Subscription.users_to_sub(ad)
    unless users_ids.blank?
      mes_queue<<[ad, users_ids]
    end
  end
  private

  def parse_tr tr
  begin
    tds = tr.css('td')
    make, model =tds[2].text.strip.split(' ',3)[0,2]
    #идентификатор объявления на сайте
    site_id=tr['data-bull-id'].to_i
    #избегаем дублирования объявлений в БД
    return false if Ad.find_by_site_id site_id
    ad=Ad.new(date: date = tds[0].text.to_date,
                make: make,
                model: model,
                year: tds[2].text.scan(/\d+/)[0].to_i,
                price: tds[6].text.delete(' ').scan(/\d+/)[0].to_i,
                link: tds[0].css('a')[0]['href'],
                site_id: site_id,
                region_id: region = Town.find_region_by_name(tds[6].css('span')[1].text))
    rescue NameError=> e
      return false
    end
  end
end

