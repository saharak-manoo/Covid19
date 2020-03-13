class Time
  def date_formatted
    self.strftime("%d/%m/%Y") rescue ""
  end

  def datetime_formatted
    self.strftime('%d/%m/%Y เมื่อเวลา %H:%M') rescue ''
  end

  def datetime_for_calender
    self.strftime('%Y-%m-%d %H:%M:%S') rescue ''
  end
end
