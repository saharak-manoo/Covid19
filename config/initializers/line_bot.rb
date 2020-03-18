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

  def self.data_covid(resp)
    contents = []
    header = "ทั่วโลก"
    date = Date.yesterday
    isConfirmed = resp[:parameters][:confirmed].present?
    isHealings = resp[:parameters][:healings].present?
    isRecovered = resp[:parameters][:recovered].present?
    isDeaths = resp[:parameters][:deaths].present?

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
      contents << "ติดเชื้อทั้งหมด #{to_delimited(data[:confirmed])} คน"
    elsif isHealings
      contents <<  "กำลังรักษาทั้งหมด #{to_delimited(data[:healings])} คน"
    elsif isRecovered
      contents <<  "รักษาหายแล้วทั้งหมด #{to_delimited(data[:recovered])} คน"
    elsif isDeaths
      contents <<  "เสียชีวิตแล้วทั้งหมด #{to_delimited(data[:deaths])} คน"
    elsif !isConfirmed && !isHealings && !isRecovered && !isDeaths
      contents = [
        "ติดเชื้อทั้งหมด #{to_delimited(data[:confirmed])} คน",
        "กำลังรักษาทั้งหมด #{to_delimited(data[:healings])} คน",
        "รักษาหายแล้วทั้งหมด #{to_delimited(data[:recovered])} คน",
        "เสียชีวิตแล้วทั้งหมด #{to_delimited(data[:deaths])} คน"
    ]
    end
      
    flex(bubble_message(header, contents, footer, 'https://www.autoinfo.co.th/wp-content/uploads/2020/03/55.jpg'), header)
  end

  def self.to_delimited(number)
    ActiveSupport::NumberHelper.number_to_delimited(number)
  end

  def self.data_hospital(hospitals)
    bubble_messages = []

    hospitals.limit(5).each do |hospital|
      contents = [
        "ที่อยู่ : #{hospital.address}",
        "เบอร์โทร : #{hospital.phone}"
      ]

      bubble_messages << bubble_message(
        hospital.name, 
        contents, 
        hospital.estimated_examination_fees, 
        'https://image.makewebeasy.net/makeweb/r_600x0/amoluGlRn/Data/c03433b120249dba3f3627c135690521.jpg'
      )
    end

    {
      type: "flex",
      altText: "สถานที่ตรวจหาโรค/รักษา (#{hospitals.count} แห่ง)",
      contents: {
       {
  "type": "carousel",
  "contents": [
    {
      "type": "bubble",
      "hero": {
        "type": "image",
        "size": "full",
        "aspectRatio": "20:13",
        "aspectMode": "cover",
        "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/01_5_carousel.png"
      },
      "body": {
        "type": "box",
        "layout": "vertical",
        "spacing": "sm",
        "contents": [
          {
            "type": "text",
            "text": "Arm Chair, White",
            "wrap": true,
            "weight": "bold",
            "size": "xl"
          },
          {
            "type": "box",
            "layout": "baseline",
            "contents": [
              {
                "type": "text",
                "text": "$49",
                "wrap": true,
                "weight": "bold",
                "size": "xl",
                "flex": 0
              },
              {
                "type": "text",
                "text": ".99",
                "wrap": true,
                "weight": "bold",
                "size": "sm",
                "flex": 0
              }
            ]
          }
        ]
      },
      "footer": {
        "type": "box",
        "layout": "vertical",
        "spacing": "sm",
        "contents": [
          {
            "type": "button",
            "style": "primary",
            "action": {
              "type": "uri",
              "label": "Add to Cart",
              "uri": "https://linecorp.com"
            }
          },
          {
            "type": "button",
            "action": {
              "type": "uri",
              "label": "Add to wishlist",
              "uri": "https://linecorp.com"
            }
          }
        ]
      }
    },
    {
      "type": "bubble",
      "hero": {
        "type": "image",
        "size": "full",
        "aspectRatio": "20:13",
        "aspectMode": "cover",
        "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/01_6_carousel.png"
      },
      "body": {
        "type": "box",
        "layout": "vertical",
        "spacing": "sm",
        "contents": [
          {
            "type": "text",
            "text": "Metal Desk Lamp",
            "wrap": true,
            "weight": "bold",
            "size": "xl"
          },
          {
            "type": "box",
            "layout": "baseline",
            "flex": 1,
            "contents": [
              {
                "type": "text",
                "text": "$11",
                "wrap": true,
                "weight": "bold",
                "size": "xl",
                "flex": 0
              },
              {
                "type": "text",
                "text": ".99",
                "wrap": true,
                "weight": "bold",
                "size": "sm",
                "flex": 0
              }
            ]
          },
          {
            "type": "text",
            "text": "Temporarily out of stock",
            "wrap": true,
            "size": "xxs",
            "margin": "md",
            "color": "#ff5551",
            "flex": 0
          }
        ]
      },
      "footer": {
        "type": "box",
        "layout": "vertical",
        "spacing": "sm",
        "contents": [
          {
            "type": "button",
            "flex": 2,
            "style": "primary",
            "color": "#aaaaaa",
            "action": {
              "type": "uri",
              "label": "Add to Cart",
              "uri": "https://linecorp.com"
            }
          },
          {
            "type": "button",
            "action": {
              "type": "uri",
              "label": "Add to wish list",
              "uri": "https://linecorp.com"
            }
          }
        ]
      }
    },
    {
      "type": "bubble",
      "body": {
        "type": "box",
        "layout": "vertical",
        "spacing": "sm",
        "contents": [
          {
            "type": "button",
            "flex": 1,
            "gravity": "center",
            "action": {
              "type": "uri",
              "label": "See more",
              "uri": "https://linecorp.com"
            }
          }
        ]
      }
    }
  ]
}
      }
    } 
  end

  def self.flex(messages, header)
    {
      type: "flex",
      altText: "ข้อมูลไวรัสโควิด #{header}",
      contents: messages
    }
  end

  def self.bubble_message(header, data, footer, image)
    contents = []
    data.each do |text|
      contents << {
        type: "text",
        text: text,
        flex: 3,
        size: "md",
        gravity: "center",
        wrap: true
      }
      
      contents << {
        type: "separator"
      }
    end

    {
      type: "bubble",
      header: {
        type: "box",
        layout: "horizontal",
        contents: [
          {
            type: "text",
            text: header,
            size: "lg",
            weight: "bold",
            color: "#565656",
            wrap: true
          }
        ]
      },
      hero: {
        type: "image",
        url: image,
        size: "full",
        aspectRatio: "16:9",
        aspectMode: "cover",
        action: {
          type: "uri",
          label: "Action",
          uri: "https://data-covid-2019.herokuapp.com/"
        }
      },
      body: {
        type: "box",
        layout: "vertical",
        spacing: "sm",
        margin: "md",
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
            wrap: true,
            size: "xs",
          }
        ]
      }
    }
  end
end