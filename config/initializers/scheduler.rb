scheduler = Rufus::Scheduler::singleton

scheduler.every '1m' do
  ap ">>> thailand summary"

  begin
    Covid.thailand_summary
    ap ">>> thailand summary done"
  rescue Exception
    Covid.thailand_summary
    ap ">>> thailand summary Exception"
    line_notify = LineNotify.new('zEEjy0TBSVM66PDy4gRzPK6leQHxiyFFGESSwd9uiWV')
    options = { message: 'Thailand summary มี error' }
    line_notify.ping(options)
  end
end

scheduler.every '5m' do
  ap ">>> global summary"

  begin
    Covid.global_summary
    ap ">>> global summary done"
  rescue Exception
    ap ">>> global summary Exception"
    line_notify = LineNotify.new('zEEjy0TBSVM66PDy4gRzPK6leQHxiyFFGESSwd9uiWV')
    options = { message: 'Global summary มี error' }
    line_notify.ping(options)
  end
end