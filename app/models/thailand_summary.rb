class ThailandSummary < ApplicationRecord
  before_save :send_notification
  validates_uniqueness_of :date

  def send_notification
    meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ประเทศไทย \n- เพิ่มขึ้น #{confirmed_add_today&.to_delimited || 0} คน \n\n- ติดเชื้อ #{confirmed&.to_delimited || 0} คน \n- กำลังรักษา #{healings&.to_delimited || 0} คน \n- เพิ่มขึ้น #{healings_add_today&.to_delimited || 0} \n- อาการหนัก #{critical&.to_delimited || 0} คน \n- เพิ่มขึ้น #{critical_add_today&.to_delimited || 0} คน \n- หายแล้ว #{recovered&.to_delimited || 0} คน \n- เพิ่มขึ้น #{recovered_add_today&.to_delimited || 0} คน \n- เสียชีวิต #{deaths&.to_delimited || 0} คน \n- เพิ่มขึ้น #{deaths_add_today&.to_delimited || 0} คน \n- เฝ้าระวัง #{watch_out_collectors&.to_delimited || 0} คน \n- เพิ่มขึ้น #{new_watch_out&.to_delimited || 0} คน \n\n* #{DateTime.now.last_updated}"

    if self.changed?
      LineBot.broadcast_thailand_summary(self)
      LineNoti.send(meesage)
    end  
  end

  def yesterday
    yesterday = ThailandSummary.find_by(date: Date.yesterday)
  end

  def healings_add_today
    (healings - (yesterday&.healings || 0)).non_negative
  end

  def critical_add_today
    (critical - (yesterday&.critical || 0)).non_negative
  end

  def recovered_add_today
    (recovered - (yesterday&.recovered || 0)).non_negative
  end

  def deaths_add_today
    (deaths - (yesterday&.deaths || 0)).non_negative
  end

  def case_management_admit_add_today
    (case_management_admit -  (yesterday&.case_management_admit || 0)).non_negative
  end

  def case_management_observation_add_today
    (case_management_observation -  (yesterday&.case_management_observation || 0)).non_negative
  end

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:healings_add_today] = healings_add_today
      json[:critical_add_today] = critical_add_today
      json[:recovered_add_today] = recovered_add_today
      json[:deaths_add_today] = deaths_add_today
      json[:watch_out_collectors_add_today] = new_watch_out
      json[:case_management_admit_add_today] = case_management_admit_add_today
      json[:case_management_observation_add_today] = case_management_observation_add_today
      json[:last_updated] = last_updated

      json&.with_indifferent_access
    else
      super()
    end   
  end
end
