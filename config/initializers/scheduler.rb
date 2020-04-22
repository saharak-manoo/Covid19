# scheduler = Rufus::Scheduler::singleton

# scheduler.every '1m' do
#   begin
#     Covid.thailand_summary
#   rescue ActiveRecord::ConnectionNotEstablished
#     # ไม่มีอะไร Updated
#   rescue => e
#     LineNoti.send_to_dev("ไม่สามารถ Updated Thailand ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
#   end
# end 

# scheduler.every '5m' do
#   begin
#     Covid.global_summary
#   rescue ActiveRecord::ConnectionNotEstablished
#     # ไม่มีอะไร Updated
#   rescue => e
#     Covid.global_summary_workpoint
#     LineNoti.send_to_dev("ไม่สามารถ Updated Global ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
#   end
# end

# scheduler.every '10m' do
#   begin
#     Covid.save_thailand_cases
#   rescue ActiveRecord::ConnectionNotEstablished
#     # ไม่มีอะไร Updated
#   rescue => e
#     LineNoti.send_to_dev("ไม่สามารถ Updated thailand cases ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
#   end
# end  

# scheduler.every '30m' do
#   begin
#     Covid.save_world
#   rescue ActiveRecord::ConnectionNotEstablished
#     # ไม่มีอะไร Updated
#   rescue => e
#     LineNoti.send_to_dev("ไม่สามารถ Updated world ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
#   end
# end

# scheduler.every '40m' do
#   begin
#     Covid.thailand_infected_province
#   rescue ActiveRecord::ConnectionNotEstablished
#     # ไม่มีอะไร Updated
#   rescue => e
#     LineNoti.send_to_dev("ไม่สามารถ Updated Thailand infected province ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
#   end
# end 

# scheduler.every '6h' do
#   begin
#     LineBot.broadcast_global_summary
#   rescue ActiveRecord::ConnectionNotEstablished
#     # ไม่มีอะไร Updated
#   rescue => e
#     LineNoti.send_to_dev("ไม่สามารถ broadcast world ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
#   end
# end  
