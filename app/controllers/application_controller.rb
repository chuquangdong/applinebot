require 'sinatra'
require 'line/bot'
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def index
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = 'b2e262da57e6a3207f53a6208ce3a207'
      config.channel_token = '9rOfSLoLxFQYxMwylSJ4FXJbvw8XUaf/zQTvL952Zjv9ChUV962fUrHgTP+WMu6WurdcJ6jty6tCKGq1giNcQbkNLmRV7r+10rtmmeT5YTv/IM8OraN4VZJORQgkobDo5KzweFRTGjm8N6KZfugNMwdB04t89/1O/w1cDnyilFU='
    }
    body = request.body.read
    events = @client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
              type: 'text',
              text: event.message['text']
          }
          @client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = @client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    }
     return
  end
end
