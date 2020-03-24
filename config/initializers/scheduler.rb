scheduler = Rufus::Scheduler::singleton

$deploy_noti = false
$thai_last_updated = 0
$world_last_updated = 0

scheduler.every '1m' do
  deploy_noti
  thai
  world
end

def deploy_noti
  unless $deploy_noti
    LineNoti.send('มีการปรับปรุงเว็ป หรือ Line Bot')
    ap "=> deploy notification send"
    $deploy_noti = true
  end
end

def thai
  data = Covid.constants

  meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ประเทศไทย \n- เพิ่มขึ้น #{data[:add_today_count].to_delimited} คน \n\n- ติดเชื้อ #{data[:confirmed].to_delimited} คน \n- กำลังรักษา #{data[:healings].to_delimited} คน \n- หายแล้ว #{data[:recovered].to_delimited} คน \n- เสียชีวิต #{data[:deaths].to_delimited} คน \n\n* #{data[:last_updated]}"

  ap "=> scheduler thai"

  if $thai_last_updated != data[:confirmed]
    LineNoti.send(meesage)
    ap "=> scheduler thai send"
    $thai_last_updated = data[:confirmed]
  end
end

def world
  data = Covid.global_summary

  meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ทั่วโลก \n- เพิ่มขึ้น #{data[:confirmed_add_today].to_delimited} คน \n\n- ติดเชื้อ #{data[:confirmed].to_delimited} คน \n- กำลังรักษา #{data[:healings].to_delimited} คน \n- อาการหนัก #{data[:critical].to_delimited} คน \n- หายแล้ว #{data[:recovered].to_delimited} คน \n- เสียชีวิต #{data[:deaths].to_delimited} คน \n- เสียชีวิตเพิ่มขึ้น #{data[:deaths_add_today].to_delimited} คน \n\n* #{data[:last_updated]}"

  ap "=> scheduler world"

  if $world_last_updated != data[:confirmed]
    LineNoti.send(meesage)
    ap "=> scheduler world send"
    $world_last_updated = data[:confirmed]
  end
end