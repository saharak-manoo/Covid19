class ThailandSummary < ApplicationRecord
  before_save :send_notification

  def send_notification
    meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ประเทศไทย \n- เพิ่มขึ้น #{confirmed_add_today&.to_delimited || 0} คน \n\n- ติดเชื้อ #{confirmed&.to_delimited || 0} คน \n- กำลังรักษา #{healings&.to_delimited || 0} คน \n- อาการหนัก #{critical&.to_delimited || 0} คน \n- หายแล้ว #{recovered&.to_delimited || 0} คน \n- เสียชีวิต #{deaths&.to_delimited || 0} คน \n- เฝ้าระวัง #{watch_out_collectors&.to_delimited || 0} คน \n- อยู่ที่ รพ. #{case_management_admit&.to_delimited || 0} คน \n- สังเกตอาการที่ รพ. #{case_management_observation&.to_delimited || 0} คน \n\n* #{last_updated}"

    LineNoti.send(meesage) if self.changed?
  end

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:deaths_add_today] = deaths - (ThailandSummary.find_by(date: Date.yesterday)&.deaths || 0)
      json[:last_updated] = last_updated

      json
    else
      super()
    end   
  end
end