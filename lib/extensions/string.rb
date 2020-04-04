class String
  MONTHS = [["มกราคม", "Jan"], ["กุมภาพันธ์", "Feb"], ["มีนาคม", "Mar"], ["เมษายน", "Apr"], ["พฤษภาคม", "May"], ["มิถุนายน", "Jun"], ["กรกฎาคม", "Jul"], ["สิงหาคม", "Aug"], ["กันยายน", "Sep"], ["ตุลาคม", "Oct"], ["พฤศจิกายน", "Nov"], ["ธันวาคม", "Dec"]]

  def to_key
    self.gsub(/(\s\-|\s)/, "_").downcase
  end

  def to_map_pin
    {
      url: self,
      scaledSize: {
        width: 30,
        height: 30
      }
    }
  end

  def difference_language_to_date
    date = nil
    MONTHS.each do |cyrillic_month, latin_month|    
      date = Date.parse(self.gsub!(/#{cyrillic_month}/, latin_month)) if self.match(cyrillic_month)
    end

    date
  end

  def difference_language_to_datetime
    date = nil
    MONTHS.each do |cyrillic_month, latin_month|    
      date = DateTime.parse(self.gsub!(/#{cyrillic_month}/, latin_month)).localtime if self.match(cyrillic_month)
    end

    date
  end
end