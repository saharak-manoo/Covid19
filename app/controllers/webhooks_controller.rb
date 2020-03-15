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
          resp = Dialogflow.send(event.message['text'])
          covid_total = Covid.total

          if resp[:intent_name] == "Covid"
            LineBot.reply(event['replyToken'], "ทั่วโลก ติดเชื้อทั้งหมด #{number_to_delimited(covid_total[:confirmed])} คน") if resp[:parameters][:confirmed].present?
            LineBot.reply(event['replyToken'], "ทั่วโลก กำลังรักษาทั้งหมด #{number_to_delimited(covid_total[:healings])} คน") if resp[:parameters][:healings].present?
            LineBot.reply(event['replyToken'], "ทั่วโลก รักษาหายแล้วทั้งหมด #{number_to_delimited(covid_total[:recovered])} คน") if resp[:parameters][:recovered].present?
            LineBot.reply(event['replyToken'], "ทั่วโลก เสียชีวิตแล้วทั้งหมด #{number_to_delimited(covid_total[:deaths])} คน") if resp[:parameters][:deaths].present?

            if resp[:parameters][:language].present?
              data = Covid.country('TH')
              LineBot.reply(event['replyToken'], "คนไทย \nติดเชื้อทั้งหมด #{number_to_delimited(data[:confirmed])} คน \nกำลังรักษา #{number_to_delimited(data[:healings])} คน \nรักษาหายแล้ว #{number_to_delimited(data[:recovered])} คน \nตาย #{number_to_delimited(data[:deaths])} คน")
            else
              LineBot.reply(event['replyToken'], resp[:fulfillment][:speech])
            end

            LineBot.reply(event['replyToken'], "ข้อมูลนี้ #{data[:last_updated]}")
          else
            LineBot.reply(event['replyToken'], resp[:fulfillment][:speech])
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