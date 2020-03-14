class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session
  
  def callback
    body = request.body.read

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          bot_message = ""
          response = Dialogflow.send(event.message['text'])

          if response[:intent_name] == "Covid19"
            data = Covid.country('TH')
            bot_message = "คนไทยติดเชื้อทั้งหมด #{data[:confirmed]} กำลังรักษา #{data[:healings]} รักษาหายแล้ว #{data[:recovered]} และตาย #{data[:deaths]} ข้อมูลนี้#{data[:last_updated]}"
          else
            bot_message = response[:fulfillment][:speech]
          end

          message = {
            type: 'text',
            text: bot_message
          }

          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    end

    render json: { message: 'OK' }, status: :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV["line_channel_id"]
      config.channel_secret = ENV["line_channel_secret"]
      config.channel_token = ENV["line_channel_token"]
    }
  end
end