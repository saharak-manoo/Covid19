class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session
  
  def callback
    body = request.body.read

    events = LineBot.client.parse_events_from(body)
    events.each do |event|
      message = event.message['text']
      line_user_id = event['source']['userId']

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          resp = Dialogflow.send(message)

          if resp[:intent_name] == "COVID-DATA"
            LineBot.reply(event['replyToken'], LineBot.data_covid(resp))
          elsif resp[:intent_name] == "COVID-HOSPITAL"
            UserTempChat.where(line_user_id: line_user_id).delete_all
            UserTempChat.create(line_user_id: line_user_id, message: message, intent_name: resp[:intent_name])

            LineBot.reply(event['replyToken'], LineBot.quick_reply_location)
          elsif resp[:intent_name] == "COVID-INFECTED"
            UserTempChat.where(line_user_id: line_user_id).delete_all
            UserTempChat.create(line_user_id: line_user_id, message: message, intent_name: resp[:intent_name])
            
            LineBot.reply(event['replyToken'], LineBot.quick_reply_location)
          elsif resp[:intent_name] == "COVID-MAX"
            parameters = resp[:parameters].as_json
            if parameters['max-ten-country'].present?
              worlds = World.order(confirmed: :desc).limit(10).as_json({api: true})
              box_messages = worlds.map.with_index { |world, index| LineBot.flex_world(world, "#{index + 1}.") }

              LineBot.reply(event['replyToken'], LineBot.flex_carousel(box_messages, "ข้อมูล #{parameters['max-ten-country']}"))
            elsif parameters['max-country'].present?
              world = World.order(confirmed: :desc).limit(1).first.as_json({api: true})

              LineBot.reply(event['replyToken'], LineBot.flex(LineBot.flex_world(world, '1.'), "ประเทศที่มีผู้ติดเชื้อเยอะที่สุดในโลก"))
            elsif parameters['max-ten-thailand'].present?
              provinces = InfectedProvince.where(date: Date.today).order(infected: :desc).limit(10).as_json({api: true})
              box_messages = provinces.map.with_index { |province, index| LineBot.flex_province(province, "#{index + 1}.") }

              LineBot.reply(event['replyToken'], LineBot.flex_carousel(box_messages, "ข้อมูล #{parameters['max-ten-thailand']}"))
            elsif parameters['max-thailand'].present?
              province = InfectedProvince.where(date: Date.today).order(infected: :desc).limit(1).first.as_json({api: true})

              LineBot.reply(event['replyToken'], LineBot.flex(LineBot.flex_province(province, '1.'), 'จังหวัดที่ติดเชื้อเยอะที่สุดในประเทศไทย'))
            end
          elsif resp[:intent_name] == "COVID-RISKY-AREA"
            risky_areas = Covid.thailand_area.sort! { |a, b| a[:date] <=> b[:date] }
            parameters = resp[:parameters].as_json

            if parameters['province'].present?
              box_messages = []
              infected_province = InfectedProvince.where(date: Date.today)
                                                  .find_by("name ILIKE :keyword", keyword: "%#{parameters['province']}%")
                                                  .as_json({api: true})

              flex_province = LineBot.flex_province(infected_province)

              if parameters['risky-area'].present?
                risky_areas = risky_areas.select { |area| area[:province].include?(parameters['province']) }.take(9).reverse
                box_messages << flex_province
                unless risky_areas.size.zero?
                  box_messages.concat(risky_areas.map.with_index { |area, index| LineBot.flex_risky_area(area, "#{index + 1}.") })
                else
                  box_messages << LineBot.flex_no_data_risky_area
                end  

                LineBot.reply(event['replyToken'], LineBot.flex_carousel(box_messages, "ข้อมูล พื้นที่เสี่ยงในจังหวัด #{parameters['province']} ล่าสุด 10 แห่ง"))
              elsif !parameters['risky-area'].present?
                LineBot.reply(event['replyToken'], LineBot.flex(flex_province, "ข้อมูลจำนวนผู้ติดเชื้อในจังหวัด #{parameters['province']}"))
              else
                LineBot.reply(event['replyToken'], { type: 'text', text: resp[:fulfillment][:speech] })
              end
            else
              risky_areas = risky_areas.take(10).reverse
              box_messages = risky_areas.map.with_index { |area, index| LineBot.flex_risky_area(area, "#{index + 1}.") }

              LineBot.reply(event['replyToken'], LineBot.flex_carousel(box_messages, "ข้อมูล พื้นที่เสียงล่าสุด 10 แห่ง"))
            end   
          else
            LineBot.reply(event['replyToken'], { type: 'text', text: resp[:fulfillment][:speech] })
          end
        when Line::Bot::Event::MessageType::Location
          title = event.message['title']
          address = event.message['address']
          latitude = event.message['latitude'] || 13.7530066
          longitude = event.message['longitude'] || 100.4960144
          location = title.present? ? title : address
          user_temp_chat = UserTempChat.find_by(line_user_id: line_user_id)
          
          case user_temp_chat&.intent_name
          when "COVID-HOSPITAL"
            hospitals = Hospital.within(15, origin: [latitude, longitude])
                                .limit(10)
                                .as_json({api: true, lat: latitude, long: longitude})
                                .sort_by! { |hospital| hospital[:kilometers] }

            unless hospitals.count.zero?
              LineBot.reply(event['replyToken'], LineBot.data_hospital(hospitals, location))
            else
              LineBot.reply(event['replyToken'], LineBot.quick_reply_location("ขออภัย ไม่มีโรงบาลที่รับตรวจโควิด19 ใกล้ #{location} ในระยะทางไม่เกิน 15 กิโลเมตรเลย โปรดส่งตำแหน่งของคุณใหม่ หรือข้อมูลด้านอื่น เลือกได้เลยครับ"))
            end
          when "COVID-INFECTED"
            thailand_cases = ThailandCase.within(15, origin: [latitude, longitude])
                                         .limit(10)
                                         .as_json({api: true, lat: latitude, long: longitude})
                                         .sort_by! { |thailand_case| thailand_case[:kilometers] }

            unless thailand_cases.count.zero?
              LineBot.reply(event['replyToken'], LineBot.data_thailand_case(thailand_cases, location))
            else
              LineBot.reply(event['replyToken'], { type: 'text', text: "ไม่มีข้อมูล ผู้ติดเชื้อในบริเวณนี้" })
            end
          else
            LineBot.reply(event['replyToken'], { type: 'text', text: "โปรดแจ้งเรื่องที่คุณอยากรู้ เช่น ที่ตรวจโควิด, ผู้ติดเชื้อ ใกล้ฉัน" })
          end

          UserTempChat.where(line_user_id: line_user_id).delete_all
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