class Tel_bot
  require 'net/http'
  require 'json'
  TOKEN='241086486:AAGqWTdX3Sr-hW8OCkDYNqwRwgoHcVcfRFQ'
  SEND_MESSAGE_PATH = '/bot241086486:AAGqWTdX3Sr-hW8OCkDYNqwRwgoHcVcfRFQ/sendMessage'
  GET_UPDATES_PATH = '/bot241086486:AAGqWTdX3Sr-hW8OCkDYNqwRwgoHcVcfRFQ/getUpdates'
  @@mes_queue=Queue.new
  @@update_id=0
  def initialize (token, uri)
    @token = token
    @uri= URI uri
  end

  def self.run
    uri = URI 'https://api.telegram.org/'
    Net::HTTP.start uri.host, uri.port, use_ssl: true do |http|
      Thread.new do
        loop do
          updates = get_updates http
          start unless updates.message == 'OK'
          messages = get_messages updates
          if messages
            messages.each do |message|
              request http, message
            end
          end
          send_cars http
          sleep 10
        end #loop
      end# thread
    end#net.http
  end


  class Message
    attr_accessor :username, :chat_id, :text
    def initialize (mes)
      @username = mes['from']['username']
      @chat_id = mes['chat']['id']
      @text = mes['text']
    end
  end
  private
  # Принимаем все новые сообщения, посланные нашему телеграм- боту
  def self.get_updates (http)
    path=GET_UPDATES_PATH
    http.post path, "offset=#{@@update_id}"
  end

  # Возвращает массив сообщений, "вынутый" из тела отклика, принятого от телеграм
  def self.get_messages (updates)
    updates = JSON.parse updates.body
    return false unless updates['ok']
    messages=[]
    updates = updates['result']
    return false if updates.empty?
    @@update_id=updates.last['update_id']+1
    updates.map do |update|
      message = Message.new update['message']
      messages << message
    end
    return messages
  end

  #передает из парсера в телеграм новое объявление и список пользователей для рассылки
  def self.push (obj)
    @@mes_queue << obj
  end

  def self.request (http, message)
    user=User.find_by_t_username message.username
    if user
      path = SEND_MESSAGE_PATH
      case message.text
        when '/auth'
          user.update verified: true
          response = http.post(path, "chat_id=#{message.chat_id}&text=Регистрация завершена успешно, теперь Вы можете создавать подписки.")#chat_id: message.chat_id, text: "Регистрация завершена успешно, теперь Вы можете создавать подписки.")
        when '/start'
          user.update chat_id: message.chat_id
          response = http.post(path, "chat_id=#{message.chat_id}&text=Рассылка запущена!")

        when '/stop'
          user.update chat_id: 0
          response = http.post(path, "chat_id=#{message.chat_id}&text=Рассылка остановлена!")
      end #case
    else
      response = http.post(path, "chat_id=#{message.chat_id}&text=К сожалению, пользователь #{message.username} не обнаружен")
    end  #if
  end

  def self.send_cars (http)
   until @@mes_queue.empty?
     obj = @@mes_queue.pop
     ad = obj[:a]
     users_ids = obj[:ids]
     continue if !ad || !users_ids
     users_ids.each do |id|
       user = User.on_user(id)
       if user
         text = "#{ad.make}  #{ad.model}  #{ad.year}года цена #{ad.price}руб #{ad.link}"
         http.post SEND_MESSAGE_PATH, "chat_id=#{user.chat_id}&text=#{text}parse_mode=html"
       end
     end
   end
  end

end
