scheduler = Rufus::Scheduler::singleton

scheduler.every '1m' do
  begin
    Covid.thailand_summary
  rescue => e
    LineNoti.send_to_dev("ไม่สามารถ Updated Thailand ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end

scheduler.every '3m' do
  begin
    Covid.thailand_infected_province
  rescue => e
    LineNoti.send_to_dev("ไม่สามารถ Updated Thailand infected province ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end  

scheduler.every '5m' do
  begin
    Covid.global_summary
  rescue => e
    Covid.global_summary_workpoint
    ap ">>> global summary Exception"
    LineNoti.send_to_dev("ไม่สามารถ Updated Global ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end

scheduler.every '30m' do
  begin
    Covid.save_world
  rescue => e
    ap ">>> World Exception"
    LineNoti.send_to_dev("ไม่สามารถ Updated world ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end

scheduler.every '12h' do
  begin
    LineBot.broadcast_global_summary
  rescue => e
    LineNoti.send_to_dev("ไม่สามารถ broadcast world ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end  
