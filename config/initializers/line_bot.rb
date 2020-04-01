class LineBot
  THAI = ['ไทย', 'ไท', 'ประเทศไทย', 'ทั่วไทย', 'ทั่วไท', 'สยาม', 'เมืิองยิ้ม', 'เมืองไทย', 'ทั้งไทย', 'ทุกจังหวัด']
  WORLD = ['โลก', 'ทั่วโลก', 'บนโลก', 'โลก', 'ทุกทวีป', 'ทุกประเทศ', 'ทั้งโลก', 'ทั้งหมด']

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

  def self.broadcast(bot_message = 'สวัสดีผมคือ Bot ของ Saharak\'s')
    client.broadcast(bot_message)
  end

  def self.broadcast_thailand_summary(data = ThailandSummary.find_by(date: Date.today))
    data = data.as_json({api: true})
    header = {title: 'ประเทศไทย', sub_title: 'วันนี้ติดเชื้อเพิ่มขึ้น', sub_title_str: '0 คน'}
    header[:sub_title_str] = "#{data[:confirmed_add_today].to_delimited} คน"
    contents = data_to_str(data, false, false, false, false)
    contents << "เฝ้าระวังทั้งหมด #{data[:watch_out_collectors].to_delimited} คน \n(เพิ่มขึ้น #{data[:watch_out_collectors_add_today].to_delimited} คน)"
    contents << "อาการหนักทั้งหมด #{data[:critical].to_delimited} คน \n(เพิ่มขึ้น #{data[:critical_add_today].to_delimited} คน)"

    footer = "* ข้อมูลนี้ #{data[:last_updated]} \n* Broadcast ทุกครั้งเมื่อข้อมูลมีการเปลี่ยนแปลง"
    broadcast(flex(flex_msg(header, contents, footer, data[:confirmed_add_today].to_covid_color), header[:title]))
  end

  def self.broadcast_global_summary(data = GlobalSummary.find_by(date: Date.today))
    data = data.as_json({api: true})
    header = {title: 'ทั่วโลก', sub_title: 'วันนี้ติดเชื้อเพิ่มขึ้น', sub_title_str: '0 คน'}
    header[:sub_title_str] = "#{data[:confirmed_add_today].to_delimited} คน"
    contents = data_to_str(data, false, false, false, false)
    contents << "อาการหนักทั้งหมด #{data[:critical].to_delimited} คน \n(เพิ่มขึ้น #{data[:critical_add_today].to_delimited} คน)"

    footer = "* ข้อมูลนี้ #{data[:last_updated]} \n* Broadcast ทุก 6 ชั่วโมง"
    broadcast(flex(flex_msg(header, contents, footer, data[:confirmed_add_today].to_covid_color), header[:title]))
  end

  def self.data_covid(resp)
    contents = []
    data = []
    location = resp[:parameters][:location]
    header = {title: location, sub_title: 'วันนี้ติดเชื้อเพิ่มขึ้น', sub_title_str: '0 คน'}
    is_confirmed = resp[:parameters][:confirmed].present?
    is_healings = resp[:parameters][:healings].present?
    is_recovered = resp[:parameters][:recovered].present?
    is_deaths = resp[:parameters][:deaths].present?
    color = "#5026FF"

    if THAI.include?(location)
      color = "#0367D3"
      data = ThailandSummary.find_by(date: Date.today).as_json({api: true})
      header[:sub_title_str] = "#{data[:confirmed_add_today].to_delimited} คน"
      contents = data_to_str(data, is_confirmed, is_healings, is_recovered, is_deaths)
      contents << "เฝ้าระวังทั้งหมด #{data[:watch_out_collectors].to_delimited} คน \n(เพิ่มขึ้น #{data[:watch_out_collectors_add_today].to_delimited} คน)"
      contents << "อาการหนักทั้งหมด #{data[:critical].to_delimited} คน \n(เพิ่มขึ้น #{data[:critical_add_today].to_delimited} คน)"
    elsif WORLD.include?(location)
      data = GlobalSummary.find_by(date: Date.today).as_json({api: true})
      header[:sub_title_str] = "#{data[:confirmed_add_today].to_delimited} คน"
      contents = data_to_str(data, is_confirmed, is_healings, is_recovered, is_deaths)
      contents << "อาการหนักทั้งหมด #{data[:critical].to_delimited} คน \n(เพิ่มขึ้น #{data[:critical_add_today].to_delimited} คน)"
    else
      infected_province = InfectedProvince.where(date: Date.today).find_by("name ILIKE :keyword", keyword: "%#{location}%").as_json({api: true})
      world = World.find_by("country ILIKE :keyword OR country_th ILIKE :keyword", keyword: "%#{location}%").as_json({api: true})

      if infected_province.present?
        header[:title] = infected_province[:name] || location
        header[:sub_title] = 'วันนี้ติดเชื้อเพิ่มขึ้น'
        header[:sub_title_str] = "#{infected_province[:infected_add_today].to_delimited} คน"
        contents = [
          "ติดเชื้อทั้งหมด #{infected_province[:infected].to_delimited} คน",
          "เพศชาย #{infected_province[:man_total].to_delimited} คน \n(เพิ่มขึ้น #{infected_province[:man_total_add_today].to_delimited} คน)",
          "เพศหญิง #{infected_province[:woman_total].to_delimited} คน \n(เพิ่มขึ้น #{infected_province[:woman_total_add_today].to_delimited} คน)",
          "ไม่ระบุเพศ #{infected_province[:no_gender_total].to_delimited} คน \n(เพิ่มขึ้น #{infected_province[:no_gender_total_add_today].to_delimited} คน)"
        ]

        return flex(flex_msg(header, contents, "* ข้อมูลนี้ #{infected_province[:last_updated]}", infected_province[:infected_color]), header[:title])
      elsif world.present?
        header[:title] = world[:country_th] || location
        header[:sub_title] = "Country"
        header[:sub_title_str] = world[:country]
        contents = [
          "ติดเชื้อทั้งหมด #{world[:confirmed].to_delimited} คน",
          "กำลังรักษาทั้งหมด #{world[:healings].to_delimited} คน",
          "รักษาหายแล้วทั้งหมด #{world[:recovered].to_delimited} คน",
          "เสียชีวิตแล้วทั้งหมด #{world[:deaths].to_delimited} คน",
          "การเดินทาง: #{world[:travel]}"
        ]

        return flex(flex_msg(header, contents, "* ข้อมูลนี้ #{world[:last_updated]}", world[:confirmed_color]), header[:title])
      else
        return { type: 'text', text: "ขออภัยไม่มีข้อมูลของ #{location} โปรดลองเป็น ชื่อจังหวัด เช่น เชียงใหม่, กรุงเทพ" }
      end  
    end

    footer = "* ข้อมูลนี้ #{data[:last_updated]}"
    flex(flex_msg(header, contents, footer, color), header[:title])
  end

  def self.data_hospital(hospitals, address = 'คุณ')
    count = hospitals.count
    title = "สถานที่ตรวจหาโรค/รักษา ใกล้#{address} ทั้งหมด #{count} แห่ง ในระยะทางไม่เกิน 15 กิโลเมตร"
    box_messages = []

    hospitals.each do |hospital|
      header = {title: hospital[:name], sub_title: 'ประเภท', sub_title_str: hospital[:hospital_type]}
      contents = [
        "ค่าตรวจ : #{hospital[:price]}",
        "จังหวัด : #{hospital[:province]}",
        "อำเภอ : #{hospital[:district]}",
        "เบอร์โทร : #{hospital[:phone_number]}",
        "ระยะทาง : #{hospital[:kilometer_th]}",
      ]

      box_messages << flex_msg(
        header, 
        contents,
        "* 1 ใน #{count} ใกล้ฉัน ในระยะทางไม่เกิน 15 กิโลเมตร", 
        "##{'%06x' % (rand * 0xffffff)}",
        true
      )
    end

    {
      type: 'flex',
      altText: "#{title} ทั้งหมด #{hospitals&.count || 0} แห่ง",
      contents: {
        type: 'carousel',
        contents: box_messages
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

  def self.flex_msg(header, datas, footer, color, is_long_text = false)
    color = color.nil? ? "#0367D3" : color
    colors = ['#fcd35e', '#bffd59', '#5efcad', '#EF454D', '#ff4716', '#713ff9', '#29adfe', '#ffd816']
    contents = []

    datas.each_with_index do |text, index|
      contents << {
        type: "box",
        layout: "horizontal",
        contents: [{
          type: "box",
          layout: "vertical",
          contents: [{
            type: "filler"
          },
          {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "filler"
              }
            ],
            cornerRadius: "30px",
            width: "12px",
            height: "12px",
            borderWidth: "2px",
            borderColor: datas.count == 1 ? '#EF454D' : colors[index]
          },
          {
            type: "filler"
          }
        ],
          flex: 0
        }, {
          type: "text",
          text: text,
          gravity: "center",
          flex: 4,
          size: "sm",
          weight: "bold",
          wrap: true
        }],
        spacing: "lg",
        cornerRadius: "30px",
        margin: "xl"
      }
    end

    {
      type: "bubble",
      size: "mega",
      header: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: header[:title],
                color: "#ffffff",
                size: is_long_text ? "xl" : "3xl",
                flex: 4,
                weight: "bold",
                wrap: true
              }
            ]
          },
          {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: header[:sub_title],
                color: "#ffffff66",
                size: "sm",
                wrap: true
              },
              {
                type: "text",
                text: header[:sub_title_str],
                color: "#ffffff",
                size: "xl",
                flex: 4,
                weight: "bold",
                wrap: true
              }
            ]
          }
        ],
        paddingAll: "20px",
        backgroundColor: color,
        spacing: "md",
        height: "134px",
        paddingTop: "22px"
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: contents
      },
      footer: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: footer,
            size: "xs",
            weight: "bold",
            style: "normal",
            wrap: true
          }
        ]
      }
    }
  end

  def self.data_to_str(data, is_confirmed, is_healings, is_recovered, is_deaths)
    contents = []

    if is_confirmed
      contents << "ติดเชื้อทั้งหมด #{data[:confirmed].to_delimited} คน"
    elsif is_healings
      contents <<  "กำลังรักษาทั้งหมด #{data[:healings].to_delimited} คน \n(เพิ่มขึ้น #{data[:healings_add_today].to_delimited} คน)"
    elsif is_recovered
      contents <<  "รักษาหายแล้วทั้งหมด #{data[:recovered].to_delimited} คน \n(เพิ่มขึ้น #{data[:recovered_add_today].to_delimited} คน)"
    elsif is_deaths
      contents <<  "เสียชีวิตแล้วทั้งหมด #{data[:deaths].to_delimited} คน \n(เพิ่มขึ้น #{data[:deaths_add_today].to_delimited} คน)"
    elsif !is_confirmed && !is_healings && !is_recovered && !is_deaths
      contents = [
        "ติดเชื้อทั้งหมด #{data[:confirmed].to_delimited} คน",
        "กำลังรักษาทั้งหมด #{data[:healings].to_delimited} คน \n(เพิ่มขึ้น #{data[:healings_add_today].to_delimited} คน)",
        "รักษาหายแล้วทั้งหมด #{data[:recovered].to_delimited} คน \n(เพิ่มขึ้น #{data[:recovered_add_today].to_delimited} คน)",
        "เสียชีวิตแล้วทั้งหมด #{data[:deaths].to_delimited} คน \n(เพิ่มขึ้น #{data[:deaths_add_today].to_delimited} คน)"
      ]
    end
  end

  def self.quick_reply_location(title = 'โปรดส่งตำแหน่งของคุณให้เราทราบ หรือข้อมูลด้านอื่น เลือกได้เลยครับ')
    {
      type: 'text',
      text: title,
      quickReply: {
        items: [
          {
            type: 'action',
            action: {
              type: 'location',
              label: 'ส่งตำแหน่งของคุณ'
            }
          },
          {
            type: 'action',
            imageUrl: "https://cdn4.iconfinder.com/data/icons/coronavirus-1/512/wuhan-coronavirus-virus-outbreak-02-512.png",
            action: {
              type: 'message',
              label: 'ประเทศไทย',
              text: 'ประเทศไทย'
            }
          },
          {
            type: 'action',
            imageUrl: "https://cdn4.iconfinder.com/data/icons/coronavirus-1/512/wuhan-coronavirus-virus-outbreak-02-512.png",
            action: {
              type: 'message',
              label: 'ทั่วโลก',
              text: 'ทั่วโลก'
            }
          },
          {
            type: 'action',
            imageUrl: "https://cdn4.iconfinder.com/data/icons/coronavirus-1/512/wuhan-coronavirus-virus-outbreak-02-512.png",
            action: {
              type: 'message',
              label: 'กรุงเทพมหานคร',
              text: 'กรุงเทพมหานคร'
            }
          },
          {
            type: 'action',
            imageUrl: "https://cdn4.iconfinder.com/data/icons/coronavirus-1/512/wuhan-coronavirus-virus-outbreak-02-512.png",
            action: {
              type: 'message',
              label: 'เชียงใหม่',
              text: 'เชียงใหม่'
            }
          },
          {
            type: 'action',
            imageUrl: "https://cdn4.iconfinder.com/data/icons/coronavirus-1/512/wuhan-coronavirus-virus-outbreak-02-512.png",
            action: {
              type: 'message',
              label: 'สุราษฎร์ธานี',
              text: 'สุราษฎร์ธานี'
            }
          },
          {
            type: 'action',
            imageUrl: "https://cdn4.iconfinder.com/data/icons/coronavirus-1/512/wuhan-coronavirus-virus-outbreak-02-512.png",
            action: {
              type: 'message',
              label: 'ยะลา',
              text: 'ยะลา'
            }
          },
        ]
      }
    }
  end  
end
