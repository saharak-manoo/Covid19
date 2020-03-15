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
          response = Dialogflow.send(event.message['text'])
          covid_total = Covid.total

          if response[:intent_name] == "Covid"
            LineBot.reply(event['replyToken'], "ทั่วโลก ติดเชื้อทั้งหมด #{covid_total[:confirmed]} คน") if response[:parameters][:confirmed].present?
            LineBot.reply(event['replyToken'], "ทั่วโลก ติดเชื้อทั้งหมด #{covid_total[:healings]} คน") if response[:parameters][:healings].present?
            LineBot.reply(event['replyToken'], "ทั่วโลก ติดเชื้อทั้งหมด #{covid_total[:recovered]} คน") if response[:parameters][:recovered].present?
            LineBot.reply(event['replyToken'], "ทั่วโลก ติดเชื้อทั้งหมด #{covid_total[:deaths]} คน") if response[:parameters][:deaths].present?
            if response[:parameters][:language].present?
              data = Covid.country('TH')
              LineBot.reply(event['replyToken'], "คนไทย \nติดเชื้อทั้งหมด #{data[:confirmed]} คน \nกำลังรักษา #{data[:healings]} คน \nรักษาหายแล้ว #{data[:recovered]} คน \nตาย #{data[:deaths]} คน")
              LineBot.reply(event['replyToken'], "ข้อมูลนี้ #{data[:last_updated]}")
            else
              LineBot.reply(event['replyToken'], response[:fulfillment][:speech])
            end 
          else
            LineBot.reply(event['replyToken'], response[:fulfillment][:speech])
          end
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