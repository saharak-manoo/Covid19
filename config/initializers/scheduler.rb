scheduler = Rufus::Scheduler::singleton

scheduler.every '1m' do
  ap ">>> thailand summary"
  Covid.thailand_summary
end

scheduler.every '3m' do
  ap ">>> global summary"
  Covid.global_summary
end