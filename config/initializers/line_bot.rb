class LineBot
  def self.client
    lient ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV["line_channel_id"]
      config.channel_secret = ENV["line_channel_secret"]
      config.channel_token = ENV["line_channel_token"]
    }
  end

  def self.reply(reply_token, bot_message)
    client.reply_message(reply_token, bot_message)
  end

  def self.data_covid(reply_token, user_message)
    contents = []
    header = "ทั่วโลก"
    resp = Dialogflow.send(user_message)
    date = Date.yesterday
    isConfirmed = resp[:parameters][:confirmed].present?
    isHealings = resp[:parameters][:healings].present?
    isRecovered = resp[:parameters][:recovered].present?
    isDeaths = resp[:parameters][:deaths].present?

    if resp[:intent_name] == "Covid"
      if resp[:parameters][:language].present?
        data = Covid.country('TH', date)
        header = "ประเทศไทย"
      else
        data = Covid.total(date)
      end

      footer = "* ข้อมูลนี้ #{data[:last_updated]}"

      if resp[:parameters][:date_time].present?
        param_date = Date.parse(resp[:parameters][:date_time])
        if param_date == Date.today
          footer += "\nเนื่องจากน้องบอทไม่มีข้อมูลของวันนี้ \nทางน้องบอทจะนำข้อมูลที่มีอยู่ล่าสุดให้แทนนะ"
        else
          date = param_date
        end  
      end

      if isConfirmed
        contents << "- ติดเชื้อทั้งหมด #{to_delimited(data[:confirmed])} คน"
      elsif isHealings
        contents <<  "- กำลังรักษาทั้งหมด #{to_delimited(data[:healings])} คน"
      elsif isRecovered
        contents <<  "- รักษาหายแล้วทั้งหมด #{to_delimited(data[:recovered])} คน"
      elsif isDeaths
        contents <<  "- เสียชีวิตแล้วทั้งหมด #{to_delimited(data[:deaths])} คน"
      elsif !isConfirmed && !isHealings && !isRecovered && !isDeaths
        contents = [
          "- ติดเชื้อทั้งหมด #{to_delimited(data[:confirmed])} คน",
          "- กำลังรักษาทั้งหมด #{to_delimited(data[:healings])} คน",
          "- รักษาหายแล้วทั้งหมด #{to_delimited(data[:recovered])} คน",
          "- เสียชีวิตแล้วทั้งหมด #{to_delimited(data[:deaths])} คน"
      ]
      end

      
      LineBot.reply(reply_token, flex_message(header, contents, footer))
    else
      LineBot.reply(reply_token, { type: 'text', text: resp[:fulfillment][:speech] })
    end

    ap bot_message
  end

  def self.to_delimited(number)
    ActiveSupport::NumberHelper.number_to_delimited(number)
  end

  def self.flex_message(header, data, footer)
    contents = []
    data.each do |text|
      contents << {
        type: "text",
        text: text,
        flex: 3,
        size: "xs",
        gravity: "center",
        wrap: true
      }
      
      contents << {
        type: "separator"
      }
    end

    {
      type: "flex",
      altText: "Flex Message",
      contents: {
        type: "bubble",
        header: {
          type: "box",
          layout: "horizontal",
          contents: [
            {
              type: "text",
              text: header,
              size: "xl",
              weight: "bold",
              color: "#000000",
              wrap: true
            }
          ]
        },
        hero: {
          type: "image",
          url: "https://www.autoinfo.co.th/wp-content/uploads/2020/03/55.jpg",
          size: "full",
          aspectRatio: "20:13",
          aspectMode: "cover",
          action: {
            type: "uri",
            label: "Action",
            uri: "https://data-covid-2019.herokuapp.com/"
          }
        },
        body: {
          type: "box",
          layout: "horizontal",
          spacing: "md",
          contents: contents
        },
        footer: {
          type: "box",
          layout: "horizontal",
          contents: [
            {
              type: "text",
              text: footer,
              weight: "bold",
              wrap: true
            }
          ]
        }
      }
    }
  end
end