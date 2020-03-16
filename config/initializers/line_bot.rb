class LineBot
  def self.client
    lient ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV["line_channel_id"]
      config.channel_secret = ENV["line_channel_secret"]
      config.channel_token = ENV["line_channel_token"]
    }
  end

  def self.reply(reply_token, bot_message)
    message = { type: 'text', text: bot_message }
    client.reply_message(reply_token, message)
  end

  def self.data_covid(reply_token, user_message)
    bot_message = "ทั่วโลก"
    resp = Dialogflow.send(user_message)
    date = Date.yesterday
    isConfirmed = resp[:parameters][:confirmed].present?
    isHealings = resp[:parameters][:healings].present?
    isRecovered = resp[:parameters][:recovered].present?
    isDeaths = resp[:parameters][:deaths].present?

    if resp[:intent_name] == "Covid"
      if resp[:parameters][:language].present?
        data = Covid.country('TH', date)
        bot_message = resp[:parameters][:language]
      else
        data = Covid.total(date)
      end

      if resp[:parameters][:date_time].present?
        param_date = Date.parse(resp[:parameters][:date_time])
        if param_date == Date.today
          bot_message += "\n * เนื่องจากน้องบอทไม่มีข้อมูลของวันนี้ ทางน้องบอทจะนำข้อมูลที่มีอยู่ล่าสุดให้แทนนะ"
        else
          date = param_date
        end  
      end

      unless isConfirmed && isHealings && isRecovered && isDeaths
        bot_message += "\n - ติดเชื้อทั้งหมด #{to_delimited(data[:confirmed])} คน 
                        \n - กำลังรักษาทั้งหมด #{to_delimited(data[:healings])} คน
                        \n - รักษาหายแล้วทั้งหมด #{to_delimited(data[:recovered])} คน
                        \n - เสียชีวิตแล้วทั้งหมด #{to_delimited(data[:deaths])} คน"
      else
        bot_message += " ติดเชื้อทั้งหมด #{to_delimited(data[:confirmed])} คน" if isConfirmed
        bot_message += " กำลังรักษาทั้งหมด #{to_delimited(data[:healings])} คน" if isHealings
        bot_message += " รักษาหายแล้วทั้งหมด #{to_delimited(data[:recovered])} คน" if isRecovered
        bot_message += " เสียชีวิตแล้วทั้งหมด #{to_delimited(data[:deaths])} คน" if isDeaths
      end

      bot_message += "\n\n * ข้อมูลนี้ #{data[:last_updated]}"
      LineBot.reply(reply_token, bot_message)
    else
      LineBot.reply(reply_token, resp[:fulfillment][:speech])
    end
  end

  def self.to_delimited(number)
    ActiveSupport::NumberHelper.number_to_delimited(number)
  end  
end