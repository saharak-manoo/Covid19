class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session
  
  def callback
    body = request.body.read

    events = LineBot.client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          bot_message = ""
          response = Dialogflow.send(event.message['text'])

          if response[:intent_name] == "Covid"
            data = Covid.country('TH')
            bot_message = "คนไทย ติดเชื้อทั้งหมด #{data[:confirmed]} คน \nกำลังรักษา #{data[:healings]} คน \nรักษาหายแล้ว #{data[:recovered]} คน \nตาย #{data[:deaths]} คน"
          else
            bot_message = response[:fulfillment][:speech]
          end

          LineBot.client.reply(event['replyToken'], bot_message)
          LineBot.client.reply(event['replyToken'], "ข้อมูลนี้ #{data[:last_updated]}")
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    end

    render json: { message: 'OK' }, status: :ok
  end
end