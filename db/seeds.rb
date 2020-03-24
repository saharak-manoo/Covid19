# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count.zero?
  user = User.create!(email: 'admin@admin.com', first_name: 'admin', last_name: 'tester', phone_number: '0123456789',                         password: 'password', confirmed_at: Time.now)
  user.add_role :admin
  ap "create admin user => #{user.full_name}"
end

if Hospital.count.zero?
  hospitals = [{
    name: 'โรงพยาบาลจุฬาลงกรณ์',
    address: '1873 ถนนพระรามที่ ๔ แขวง ปทุมวัน เขตปทุมวัน กรุงเทพมหานคร 10330',
    phone: '02 256 4000',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 3,000-6,000 บาท',
    latitude: 13.7323667,
    longitude: 100.5356114
  },
  {
    name: 'โรงพยาบาลราชวิถี',
    address: '2 ถนน พญาไท แขวง ทุ่งพญาไท เขตราชเทวี กรุงเทพมหานคร 10400',
    phone: '02 354 8108',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 3,000-6,000 บาท',
    latitude: 13.7651513,
    longitude: 100.5340121
  },
  {
    name: 'โรงพยาบาลรามาธิบดี',
    address: 'แขวง สวนจิตรลดา เขตดุสิต กรุงเทพมหานคร 10400',
    phone: '02 201 1238',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000 บาทขึ้นไป',
    latitude: 13.7669843,
    longitude: 100.5252634
  },
  {
    name: 'โรงพยาบาลวิชัยยุทธ',
    address: '53 ซอย เศรษฐศิริ 2 แขวง พญาไท เขตพญาไท กรุงเทพมหานคร 10400',
    phone: '02 265 7777',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 7,500 บาท',
    latitude: 13.7818949,
    longitude: 100.53122
  },
  {
    name: 'โรงพยาบาลบางปะกอก 9 อินเตอร์แนชั่นแนล',
    address: 'เลขที่ 362 ถ. พระราม 2 แขวง บางมด เขตจอมทอง กรุงเทพมหานคร 10150',
    phone: '02 109 9111',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 7,500-10,000 บาท',
    latitude: 13.682015,
    longitude: 100.4724655
  },
  {
    name: 'โรงพยาบาลพญาไท 2',
    address: '943 ถนน พหลโยธิน แขวง พญาไท เขตพญาไท กรุงเทพมหานคร 10400',
    phone: '02 271 6700',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 6,100 บาท',
    latitude: 13.770479,
    longitude: 100.5384341
  },
  {
    name: 'โรงพยาบาลพญาไท 3',
    address: '111 ถนนเพชรเกษม แขวง ปากคลองภาษีเจริญ เขตภาษีเจริญ กรุงเทพมหานคร 10160',
    phone: '02 467 1111',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 6,100 บาท',
    latitude: 13.7229782,
    longitude: 100.4618867
  },
  {
    name: 'โรงพยาบาลแพทย์รังสิต',
    address: 'บริษัท ปทุมรักษ์ จำกัด ถนน พหลโยธิน ตำบลคูคต อำเภอลำลูกกา ปทุมธานี 12130',
    phone: '02 998 9999',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 8,000 บาท',
    latitude: 13.9632562,
    longitude: 100.6191923
  },
  {
    name: 'โรงพยาบาลศิริราชปิยมหาราชการุณย์',
    address: '2 ถนน วังหลัง แขวงศิริราช เขตบางกอกน้อย กรุงเทพมหานคร 10700',
    phone: '02 419 1000',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 9,900 บาท',
    latitude: 13.7599318,
    longitude: 100.483604
  },
  {
    name: 'สถาบันบำราศนราดูร',
    address: '38 หมู่ที่ 4 14 ถนน ติวานนท์ อำเภอเมืองนนทบุรี นนทบุรี 11000',
    phone: '02 951 1171',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 2,500 บาท',
    latitude: 13.8536464,
    longitude: 100.5202018
  },
  {
    name: 'โรงพยาบาลกรุงเทพคริสเตียน',
    address: '124 ถนน สีลม แขวง สุริยวงศ์ เขตบางรัก กรุงเทพมหานคร 10500',
    phone: '02 625 9000',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000-10,000 บาท',
    latitude: 13.7282658,
    longitude: 100.5290582
  },
  {
    name: 'โรงพยาบาลพระราม 9',
    address: '99 ถนน พระราม 9 แขวง บางกะปิ เขตห้วยขวาง กรุงเทพมหานคร 10310',
    phone: '02 202 9999',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 8,000-10,000 บาท',
    latitude: 13.7532287,
    longitude: 100.568783
  },
  {
    name: 'โรงพยาบาลเปาโลเมโมเรียล',
    address: '670 1 ถนน พหลโยธิน แขวง สามเสนใน เขตพญาไท กรุงเทพมหานคร 10400',
    phone: '02 279 7000',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000 บาทขึ้นไป',
    latitude: 13.7002583,
    longitude: 100.5123574
  },
  {
    name: 'โรงพยาบาลเปาโลเมโมเรียลโชคชัย 4',
    address: '1 ถนน โชคชัย 4 แขวง ลาดพร้าว เขตลาดพร้าว กรุงเทพมหานคร 10230',
    phone: '02 514 4140',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000 บาทขึ้นไป',
    latitude: 13.8132007,
    longitude: 100.5852247
  },
  {
    name: 'โรงพยาบาลเปาโลเมโมเรียลสมุทรปราการ',
    address: '123 หมู่ 8 ถนน ศรีนครินทร์ ตำบลบางเมือง อำเภอเมือง สมุทรปราการ 10270',
    phone: '02 363 2000',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000 บาทขึ้นไป',
    latitude: 13.5982788,
    longitude: 100.6124804
  },
  {
    name: 'โรงพยาบาลเปาโลเมโมเรียลรังสิต',
    address: '11, 1 ถนน รังสิต - นครนายก ตำบล ประชาธิปัตย์ อำเภอธัญบุรี ปทุมธานี 12130',
    phone: '02 577 8111',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000 บาทขึ้นไป',
    latitude: 13.9857085,
    longitude: 100.6175086
  },
  {
    name: 'โรงพยาบาลเปาโลเมโมเรียลเกษตร',
    address: '2012 5-7 ซอย พหลโยธิน 34 แขวง เสนานิคม เขตจตุจักร กรุงเทพมหานคร 10900',
    phone: '02 150 0900',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000 บาทขึ้นไป',
    latitude: 13.8353616,
    longitude: 100.5720311
  },
  {
    name: 'โรงพยาบาลเปาโลเมโมเรียลพระประแดง',
    address: 'ถนน สุขสวัสดิ์ ตำบล ปากคลองบางปลากด อำเภอพระสมุทรเจดีย์ สมุทรปราการ 10290',
    phone: '02 818 9000',
    estimated_examination_fees: 'ตรวจ COVID-19 มีค่าใช้จ่ายประมาณ 5,000 บาทขึ้นไป',
    latitude: 13.6034394,
    longitude: 100.5654459
  }]

  hospitals.each do |hospital|
    Hospital.create(hospital)
  end  
end

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