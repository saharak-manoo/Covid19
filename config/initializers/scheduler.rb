scheduler = Rufus::Scheduler::singleton

scheduler.every '1m' do
  ap ">>> thailand summary"

  begin
    Covid.thailand_summary
    ap ">>> thailand summary done"
    Covid.save_world
    ap ">>> Save world done"
  rescue => e
    ap ">>> thailand summary Exception"
    LineNoti.send_to_dev("ไม่สามารถ Updated Thailand ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end

scheduler.every '5m' do
  ap ">>> global summary"

  begin
    Covid.global_summary
    ap ">>> global summary done"
  rescue => e
    Covid.global_summary_workpoint
    ap ">>> global summary Exception"
    LineNoti.send_to_dev("ไม่สามารถ Updated Global ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
  end
end