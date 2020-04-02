# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count.zero?
  user = User.create!(email: 'admin@admin.com', first_name: 'admin', last_name: 'tester', phone_number: '0123456789', password: 'password', confirmed_at: Time.now)
  user.add_role :admin
  ap "create admin user => #{user.full_name}"
end

if Hospital.count.zero?
  hospitals = [{
    name: 'รพ.จุฬาลงกรณ์',
    province: 'กรุงเทพมหานคร',
    district: 'ปทุมวัน',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 3000,
    max_cost: 6000,
    phone_number: '02-256-5487, 02-256-4000',
    latitude: 13.7323667,
    longitude: 100.5356114,
  },
  {
    name: 'รพ.ราชวิถี',
    province: 'กรุงเทพมหานคร',
    district: 'ราชเทวี',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 3000,
    max_cost: 6000,
    phone_number: '02-354-8108-37',
    latitude: 13.7651513,
    longitude: 100.5340121
  },
  {
    name: 'รพ.รามาธิบดี',
    province: 'กรุงเทพมหานคร',
    district: 'ราชเทวี',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 5000,
    max_cost: 0,
    phone_number: '02-201-1000, 02-200-3000',
    latitude: 13.7669843,
    longitude: 100.5252634
  },
  {
    name: 'รพ.วิภาวดี',
    province: 'กรุงเทพมหานคร',
    district: 'จตุจักร',
    hospital_type: 'รพ.เอกชน',
    min_cost: 6500,
    max_cost: 0,
    phone_number: '02-561-1111',
    latitude: 13.8470979,
    longitude: 100.558748
  },
  {
    name: 'รพ.วิชัยยุทธ',
    province: 'กรุงเทพมหานคร',
    district: 'พญาไท',
    hospital_type: 'รพ.เอกชน',
    min_cost: 7500,
    max_cost: 0,
    phone_number: '02-265-7777, 02-618-6200',
    latitude: 13.7818949,
    longitude: 100.53122
  },
  {
    name: 'รพ.บางปะกอก 9 อินเตอร์เนชั่นแนล',
    province: 'กรุงเทพมหานคร',
    district: 'จอมทอง',
    hospital_type: 'รพ.เอกชน',
    min_cost: 7900,
    max_cost: 10000,
    phone_number: '02-109-9111',
    latitude: 13.682015,
    longitude: 100.4724655
  },
  {
    name: 'รพ.พญาไท 2',
    province: 'กรุงเทพมหานคร',
    district: 'พญาไท',
    hospital_type: 'รพ.เอกชน',
    min_cost: 6100,
    max_cost: 0,
    phone_number: '02-271-6700',
    latitude: 13.770479,
    longitude: 100.5384341
  },
  {
    name: 'รพ.พญาไท 3',
    province: 'กรุงเทพมหานคร',
    district: 'ภาษีเจริญ',
    hospital_type: 'รพ.เอกชน',
    min_cost: 6100,
    max_cost: 0,
    phone_number: '02-467-1111',
    latitude: 13.7229782,
    longitude: 100.4618867
  },
  {
    name: 'รพ.ลำปาง',
    province: 'ลำปาง',
    district: 'เมืองลำปาง',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 0,
    max_cost: 0,
    phone_number: '054-237-400',
    latitude: 18.2861792,
    longitude: 99.5060807
  },
  {
    name: 'รพ.บำรุงราษฎร์',
    province: 'กรุงเทพมหานคร',
    district: 'วัฒนา',
    hospital_type: 'รพ.เอกชน',
    min_cost: 0,
    max_cost: 10500,
    phone_number: '02-066-8888',
    latitude: 13.746316,
    longitude: 100.5501105
  },
  {
    name: 'สถาบันป้องกันควบคุมโรคเขตเมือง',
    province: 'กรุงเทพมหานคร',
    district: 'บางเขน',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 2700,
    max_cost: 0,
    phone_number: '02-521-0943-5',
    latitude: 13.871978,
    longitude: 100.5929063
  },
  {
    name: 'รพ.สมิติเวช',
    province: 'กรุงเทพมหานคร',
    district: 'คลองเตย',
    hospital_type: 'รพ.เอกชน',
    min_cost: 6500,
    max_cost: 0,
    phone_number: '02-022-2222',
    latitude: 13.7318699,
    longitude: 100.4936333
  },
  {
    name: 'รพ.แพทย์รังสิต',
    province: 'ปทุมธานี',
    district: 'ลำลูกกา',
    hospital_type: 'รพ.เอกชน',
    min_cost: 8000,
    max_cost: 0,
    phone_number: '02-998-9999',
    latitude: 13.9632562,
    longitude: 100.6191923
  },
  {
    name: 'รพ.ศิริราช',
    province: 'กรุงเทพมหานคร',
    district: 'บางกอกน้อย',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 9900,
    max_cost: 0,
    phone_number: '02-419-1000',
    latitude: 13.7599318,
    longitude: 100.483604
  },
  {
    name: 'สถาบันบำราศนราดูร',
    province: 'นนทบุรี',
    district: 'เมือง',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 2500,
    max_cost: 0,
    phone_number: '02-590-3402, 02-590-3427',
    latitude: 13.8536464,
    longitude: 100.5202018
  },
  {
    name: 'รพ.กรุงเทพคริสเตียน',
    province: 'กรุงเทพมหานคร',
    district: 'บางรัก',
    hospital_type: 'รพ.เอกชน',
    min_cost: 5000,
    max_cost: 10000,
    phone_number: '02-625-9000',
    latitude: 13.7282658,
    longitude: 100.5290582
  },
  {
    name: 'รw.พระราม 9',
    province: 'กรุงเทพมหานคร',
    district: 'ห้วยขวาง',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 8000,
    max_cost: 10000,
    phone_number: '02-202-9999',
    latitude: 13.7532287,
    longitude: 100.568783
  },
  {
    name: 'รพ.มหาราช (เชียงใหม่)',
    province: 'เชียงใหม่',
    district: 'เมืองเชียงใหม่',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 0,
    max_cost: 0,
    phone_number: '0-5393-6150',
    latitude: 18.7897631,
    longitude: 98.972433
  },
  {
    name: 'รพ.นพรัตน์',
    province: 'กรุงเทพมหานคร',
    district: 'คันนายาว',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 0,
    max_cost: 0,
    phone_number: '02-548-1000',
    latitude: 13.8158803,
    longitude: 100.6852525
  },
  {
    name: 'รพ.นครปฐม',
    province: 'นครปฐม',
    district: 'นครปฐม',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 0,
    max_cost: 0,
    phone_number: '034-254-1504',
    latitude: 13.8191484,
    longitude: 100.0730038
  },
  {
    name: 'รพ.เปาโล (พหลโยธิน)',
    province: 'กรุงเทพมหานคร',
    district: 'พญาไท',
    hospital_type: 'รพ.เอกชน',
    min_cost: 5000,
    max_cost: 0,
    phone_number: '02-271-7000',
    latitude: 13.7002583,
    longitude: 100.5123574
  },
  {
    name: 'รพ.เปาโล (โชคชัย4)',
    province: 'กรุงเทพมหานคร',
    district: 'ลาดพร้าว',
    hospital_type: 'รพ.เอกชน',
    min_cost: 5000,
    max_cost: 0,
    phone_number: '02-514-4140-9',
    latitude: 13.8132007,
    longitude: 100.5852247
  },
  {
    name: 'รพ.เปาโล (สมุทรปราการ)',
    province: 'กรุงเทพมหานคร',
    district: 'เมือง',
    hospital_type: 'รพ.เอกชน',
    min_cost: 5000,
    max_cost: 0,
    phone_number: '02-363-2000',
    latitude: 13.5982788,
    longitude: 100.6124804
  },
  {
    name: 'รพ.เปาโล (รังสิต)',
    province: 'ปทุมธานี',
    district: 'ธัญบุรี',
    hospital_type: 'รพ.เอกชน',
    min_cost: 5000,
    max_cost: 0,
    phone_number: '02-577-8111',
    latitude: 13.9857085,
    longitude: 100.6175086
  },
  {
    name: 'รพ.เปาโล (เกษตร)',
    province: 'กรุงเทพมหานคร',
    district: 'จตุจักร',
    hospital_type: 'รพ.เอกชน',
    min_cost: 5000,
    max_cost: 0,
    phone_number: '02-150-0900',
    latitude: 13.8353616,
    longitude: 100.5720311
  },
  {
    name: 'รพ.เปาโล (พระประแดง)',
    province: 'สมุทรปราการ',
    district: 'พระสมุทรเจดีย์',
    hospital_type: 'รพ.เอกชน',
    min_cost: 5000,
    max_cost: 0,
    phone_number: '02-818-9000',
    latitude: 13.6034394,
    longitude: 100.5654459
  },
  {
    name: 'รพ.รามคำแหง',
    province: 'กรุงเทพมหานคร',
    district: 'บางกะปิ',
    hospital_type: 'รพ.เอกชน',
    min_cost: 6500,
    max_cost: 0,
    phone_number: '02-743-9999',
    latitude: 13.7613129,
    longitude: 100.6339656
  },
  {
    name: 'ศูนย์วิทยาศาสตร์การแพทย์สุราษฎร์ธานี',
    province: 'สุราษฎร์ธานี',
    district: 'เมืองสุราษฎร์ธานี',
    hospital_type: 'รพ.รัฐฯ',
    min_cost: 0,
    max_cost: 0,
    phone_number: '077-355-301',
    latitude: 9.1318651,
    longitude: 99.2955287
  }]

  hospitals.each do |hospital|
    Hospital.create(hospital)
  end  
end

if ThailandSummary.count.zero?
  country_retroacts = Covid.country_retroact('th')

  country_retroacts.each do |key|
    retroact = key[1]
    date = retroact[:date]

    thailand_summary = ThailandSummary.find_by(date: date)
    thailand_summary = ThailandSummary.new if thailand_summary.nil?

    thailand_summary.date = date
    thailand_summary.confirmed = retroact[:confirmed]
    thailand_summary.healings = retroact[:healings]
    thailand_summary.recovered = retroact[:recovered]
    thailand_summary.deaths = retroact[:deaths]
    thailand_summary.created_at = retroact[:updated_at]
    thailand_summary.updated_at = retroact[:updated_at]

    ap "Create Thailand Summary #{date}" if thailand_summary.save
  end
end

if GlobalSummary.count.zero?
  retroacts = Covid.retroact

  retroacts.each do |key|
    retroact = key[1]
    date = retroact[:date]

    global_summary = GlobalSummary.find_by(date: date)
    global_summary = GlobalSummary.new if global_summary.nil?

    global_summary.date = date
    global_summary.confirmed = retroact[:confirmed]
    global_summary.healings = retroact[:healings]
    global_summary.recovered = retroact[:recovered]
    global_summary.deaths = retroact[:deaths]
    global_summary.created_at = retroact[:updated_at]
    global_summary.updated_at = retroact[:updated_at]

    ap "Create Global Summary #{date}" if global_summary.save
  end
end

if World.count.zero?
  Covid.save_world
end

if InfectedProvince.count.zero?
  Covid.thailand_infected_province
end

if ThailandCase.count.zero?
  Covid.save_thailand_cases
end