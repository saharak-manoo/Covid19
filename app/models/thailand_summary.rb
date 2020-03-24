class ThailandSummary < ApplicationRecord
  scope :lasted, -> { order(updated_at: :desc).first }
  after_save :send_notification

  def send_notification
    meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ประเทศไทย \n- เพิ่มขึ้น #{confirmed_add_today.to_delimited} คน \n\n- ติดเชื้อ #{confirmed.to_delimited} คน \n- กำลังรักษา #{healings.to_delimited} คน \n- อาการหนัก #{critical.to_delimited} คน \n- หายแล้ว #{recovered.to_delimited} คน \n- เสียชีวิต #{deaths.to_delimited} คน \n- เฝ้าระวัง #{watch_out_collectors.to_delimited} คน \n- อยู่ที่ รพ. #{case_management_admit.to_delimited} คน \n- สังเกตอาการที่ รพ. #{case_management_observation.to_delimited} คน \n\n* #{last_updated}"

    LineNoti.send(meesage) if updated_at_changed?
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