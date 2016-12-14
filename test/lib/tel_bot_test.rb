class TelBotTest < ActiveSupport::TestCase
  require 'tel_bot'
  test 'should get update' do
    uri = URI 'https://api.telegram.org/'
    @tel_bot = Tel_bot.new
    Net::HTTP.start uri.host, uri.port, use_ssl: true do |http|
      @updates = @tel_bot.send(:get_updates,http, 0)
      @messages, update_id = @tel_bot.send(:get_messages,@updates,0)
    end
    assert_equal 'OK', @updates.message
    assert_equal false, @messages

  end

  test 'should get response' do
    uri = URI 'https://api.telegram.org/'
    @tel_bot = Tel_bot.new
    Net::HTTP.start uri.host, uri.port, use_ssl: true do |http|
      message = Tel_bot::Message.new({"from"=>{"username"=>'keubasov'},"chat"=>{"id"=>274437371}, "text"=>'/start'})
      @response = @tel_bot.send(:request, http, message)
    end
    assert_equal "200", @response.code
    body = JSON.parse @response.body
    assert_equal body['result']['text'], 'Рассылка запущена!'
  end

  test 'should send car' do
    uri = URI 'https://api.telegram.org/'
    @tel_bot = Tel_bot.new
    make = makes(:toyota).name
    model = models(:vitz).name
    year = 2010
    price = 500000
    link = "http://drom.ru/#{make}/#{model}/123456"
    ad=Ad.new(date: Date.today,
            make: make,
            model: model,
            year: 2010,
            price: 500000,
            link: link,
            site_id: 123456,
            region_id: regions(:omsk).id)
    users_ids = []<<users(:erik).id
    @tel_bot.mes_queue.push [ad, users_ids]
    Net::HTTP.start uri.host, uri.port, use_ssl: true do |http|
      @response = @tel_bot.send(:send_cars, http)
    end
    body = JSON.parse @response.body
    assert_equal body['result']['text'], "#{make}  #{model}  #{year}года цена #{price}руб #{link}parse_mode=html"
  end

end
