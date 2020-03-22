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

  ap "scheduler thai"

  if $thai_last_updated != data[:add_today_count]
    LineNoti.send(meesage)
    ap "scheduler thai send"
    $thai_last_updated = data[:add_today_count]
  end
end

def world
  data = Covid.world
  meesage = "\n\nจำนวนผู้ติดเชื้อ Covid19 \n- ทั่วโลก \n\n- ติดเชื้อ #{to_delimited(data[:confirmed])} คน \n- กำลังรักษา #{to_delimited(data[:healings])} คน \n- หายแล้ว #{to_delimited(data[:recovered])} คน \n- เสียชีวิต #{to_delimited(data[:deaths])} คน \n\n* #{data[:last_updated]}"

  ap "scheduler world"

  if $world_last_updated != data[:add_today_count]
    LineNoti.send(meesage)
    ap "scheduler world send"
    $world_last_updated = data[:add_today_count]
  end
end

def to_delimited(number)
  ActiveSupport::NumberHelper.number_to_delimited(number)
end