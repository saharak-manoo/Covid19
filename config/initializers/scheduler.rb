scheduler = Rufus::Scheduler::singleton

$thai_last_updated = 0
$world_last_updated = 0

scheduler.every '1m' do
  thai
  world
end

def thai
  data = Covid.constants
  meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ประเทศไทย \n- เพิ่มขึ้น #{to_delimited(data[:add_today_count])} คน \n\n- ติดเชื้อ #{to_delimited(data[:confirmed])} คน \n- กำลังรักษา #{to_delimited(data[:healings])} คน \n- หายแล้ว #{to_delimited(data[:recovered])} คน \n- เสียชีวิต #{to_delimited(data[:deaths])} คน \n\n* #{data[:last_updated]}"

  ap "=> scheduler thai"

  if $thai_last_updated != data[:confirmed]
    LineNoti.send(meesage)
    ap "=> scheduler thai send"
    $thai_last_updated = data[:confirmed]
  end
end

def world
  data = Covid.world
  meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ทั่วโลก \n- เพิ่มขึ้น #{data[:add_today_count].to_delimited} คน \n\n- ติดเชื้อ #{data[:confirmed].to_delimited} คน \n- กำลังรักษา #{data[:healings].to_delimited} คน \n- หายแล้ว #{data[:recovered].to_delimited} คน \n- เสียชีวิต #{data[:deaths].to_delimited} คน \n\n* #{data[:last_updated]}"

  ap "=> scheduler world"

  if $world_last_updated != data[:confirmed]
    LineNoti.send(meesage)
    ap "=> scheduler world send"
    $world_last_updated = data[:confirmed]
  end
end