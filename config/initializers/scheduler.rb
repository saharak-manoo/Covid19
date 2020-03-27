scheduler = Rufus::Scheduler::singleton

scheduler.every '1m' do
  begin
    Covid.thailand_summary
  rescue => e
    LineNoti.send_to_dev("ไม่สามารถ Updated Thailand ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end

scheduler.every '5m' do
  begin
    Covid.global_by_ddc
  rescue => e
    Covid.global_summary_workpoint
    ap ">>> global summary Exception"
    LineNoti.send_to_dev("ไม่สามารถ Updated Global ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end

scheduler.every '1d' do
  begin
    Covid.save_world
  rescue => e
    ap ">>> World Exception"
    LineNoti.send_to_dev("ไม่สามารถ Updated world ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end  
