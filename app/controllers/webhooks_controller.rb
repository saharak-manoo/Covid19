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

          if resp[:intent_name] == "COVID-DATA"
            LineBot.reply(event['replyToken'], LineBot.data_covid(resp))
          elsif resp[:intent_name] == "COVID-HOSPITAL"
            LineBot.reply(event['replyToken'], LineBot.quick_reply_location)
          else
            LineBot.reply(event['replyToken'], { type: 'text', text: resp[:fulfillment][:speech] })
          end
        when Line::Bot::Event::MessageType::Location
          title = event.message['title']
          address = event.message['address']
          latitude = event.message['latitude'] || 13.7530066
          longitude = event.message['longitude'] || 100.4960144

          location = title.present? ? title : address
          hospitals = Hospital.within(15, origin: [latitude, longitude])
                              .limit(10)
                              .as_json({api: true, lat: latitude, long: longitude})
                              .sort_by! { |hospital| -hospital[:kilometers] }

          unless hospitals.count.zero?
            LineBot.reply(event['replyToken'], LineBot.data_hospital(hospitals, location))
          else
            LineBot.reply(event['replyToken'], LineBot.quick_reply_location("ขออภัย ไม่มีโรงบาลที่รับตรวจโควิด19 ใกล้#{location} ในระยะ 15 กิโลเมตรเลย โปรดส่งตำแหน่งของคุณใหม่ หรือข้อมูลด้านอื่น เลือกได้เลยครับ"))
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