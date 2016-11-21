class TelBotTest < ActiveSupport::TestCase
  require 'tel_bot'
  test 'should get update' do
    uri = URI 'https://api.telegram.org/'
    Net::HTTP.start uri.host, uri.port, use_ssl: true do |http|
      assert_equal 'OK', Tel_bot.get_updates(http, 0).message
    end
  end
=begin
  test 'should get message' do
    updates = Net::HTTPOK.new(1.1, 200, 'OK')
    updates.body = "{\"ok\":true,\"result\":[{\"update_id\":0,\n\"message\":{\"message_id\":134,\"text\":\"start\"}}]}"
    assert_equal 'start', Tel_bot.get_messages(updates,0).text
  end
=end

end
