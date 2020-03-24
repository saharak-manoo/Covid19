class GlobalSummary < ApplicationRecord
  scope :today, -> { find_by(date: Date.today) }
  before_save :send_notification

  def send_notification
    meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ทั่วโลก \n- เพิ่มขึ้น #{confirmed_add_today&.to_delimited || 0} คน \n\n- ติดเชื้อ #{confirmed&.to_delimited || 0} คน \n- กำลังรักษา #{healings&.to_delimited || 0} คน \n- อาการหนัก #{critical&.to_delimited || 0} คน \n- หายแล้ว #{recovered&.to_delimited || 0} คน \n- เสียชีวิต #{deaths&.to_delimited || 0} คน \n- เสียชีวิตเพิ่มขึ้น #{deaths_add_today&.to_delimited || 0} คน \n\n* #{last_updated}"

    LineNoti.send(meesage) if updated_at_changed? && date == Date.today
  end

  def last_updated
    updated_at.localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:last_updated] = last_updated

      json
    else
      super()
    end   
  end
end