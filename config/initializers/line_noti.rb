class LineNoti
  def self.send(message = 'สวัสดีเราคือ Line noti จำนวนผู้ติดเชื้อ Covid-19 สร้างโดย Saharak Manoo')
    line_notify = LineNotify.new(ENV['line_notify_token'])
    options = { message: message }
    line_notify.ping(options)
  end
end