class GlobalSummary < ApplicationRecord
  before_save :send_notification
  validates_uniqueness_of :date

  def send_notification
    meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ทั่วโลก \n- เพิ่มขึ้น #{confirmed_add_today&.to_delimited || 0} คน \n\n- ติดเชื้อ #{confirmed&.to_delimited || 0} คน \n- กำลังรักษา #{healings&.to_delimited || 0} คน \n- เพิ่มขึ้น #{healings_add_today&.to_delimited || 0} คน \n- อาการหนัก #{critical&.to_delimited || 0} คน \n- เพิ่มขึ้น #{critical_add_today&.to_delimited || 0} คน \n- หายแล้ว #{recovered&.to_delimited || 0} คน \n- เพิ่มขึ้น #{recovered_add_today&.to_delimited || 0} คน \n- เสียชีวิต #{deaths&.to_delimited || 0} คน \n- เพิ่มขึ้น #{deaths_add_today&.to_delimited || 0} คน \n\n* #{DateTime.now.last_updated}"

    LineNoti.send(meesage) if self.changed?
  end

  def yesterday
    yesterday = GlobalSummary.find_by(date: Date.yesterday)
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

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:healings_add_today] = healings_add_today
      json[:critical_add_today] = critical_add_today
      json[:recovered_add_today] = recovered_add_today
      json[:last_updated] = last_updated

      json&.with_indifferent_access
    else
      super()
    end
  end
end
