class Covid
  CATEGORIES = ['Confirmed', 'Deaths', 'Recovered']
  COUNTRY_TH = ["อัฟกานิสถาน", "แอลเบเนีย", "แอลจีเรีย", "อเมริกันซามัว", "อันดอร์รา", "แองโกลา", "แองกวิลลา", "ทวิปแอนตาร์กติกา", "แอนติกาและบาร์บูดา", "อาร์เจนตินา", "อาร์เมเนีย", "อารูบา", "ออสเตรเลีย", "ออสเตรีย", "อาเซอร์ไบจาน", "บาฮามาส", "บาห์เรน", "บังคลาเทศ", "บาร์เบโดส", "เบลารุส", "เบลเยียม", "เบลีซ", "ประเทศเบนิน", "เบอร์มิวดา", "ภูฏาน", "โบลิเวีย", "บอสเนียและเฮอร์เซโก", "บอตสวานา", "เกาะบูเวต", "บราซิล", "เขตมหาสมุทรบริติชอินเดีย", "หมู่เกาะบริติชเวอร์จิน", "บรูไน", "บัลแกเรีย", "บูร์กินาฟาโซ", "บุรุนดี", "กัมพูชา", "แคเมอรูน", "แคนาดา", "เคปเวิร์ด", "แคริบเบียนเนเธอร์แลนด์", "หมู่เกาะเคย์เเมน", "สาธารณรัฐอัฟริกากลาง", "ชาด", "ชิลี", "ประเทศจีน", "เกาะคริสต์มาส", "หมู่เกาะโคโคส (คีลิง)", "โคลอมเบีย", "คอโมโรส", "หมู่เกาะคุก", "คอสตาริกา", "โครเอเชีย", "คิวบา", "คูราเซา", "ประเทศไซปรัส", "เช็ก", "สาธารณรัฐคองโก", "เดนมาร์ก", "เจ้าหญิงไดมอนด์", "จิบูตี", "โดมินิกา", "สาธารณรัฐโดมินิกัน", "เอกวาดอร์", "อียิปต์", "เอลซัลวาดอร์", "อิเควทอเรียลกินี", "เอริเทรี", "เอสโตเนีย", "สวาซิแลนด์", "สาธารณรัฐเอธิโอเปีย", "หมู่เกาะฟอล์คแลนด์", "หมู่เกาะแฟโร", "ฟิจิ", "ฟินแลนด์", "ฝรั่งเศส", "เฟรนช์เกีย", "เฟรนช์โปลินีเซีย", "ดินแดนทางใต้ของฝรั่งเศสและแอนตาร์กติก", "ประเทศกาบอง", "แกมเบีย", "จอร์เจีย", "ประเทศเยอรมัน", "ประเทศกานา", "ยิบรอลตา", "กรีซ", "เกาะกรีนแลนด์", "เกรเนดา", "ลุป", "กวม", "กัวเตมาลา", "เสื้อไหมพรม", "ประเทศกินี", "กินีบิสเซา", "กายอานา", "ไฮติ", "เกาะ Heard และ McDonald Islands", "ฮอนดูรัส", "ฮ่องกง", "ฮังการี", "ประเทศไอซ์แลนด์", "อินเดีย", "อินโดนีเซีย", "อิหร่าน", "อิรัก", "ไอร์แลนด์", "ไอล์ออฟแมน", "อิสราเอล", "อิตาลี", "ชายฝั่งงาช้าง", "เกาะจาเมกา", "ประเทศญี่ปุ่น", "นิวเจอร์ซีย์", "จอร์แดน", "คาซัคสถาน", "ประเทศเคนย่า", "ประเทศคิริบาส", "โคโซโว", "คูเวต", "คีร์กีสถาน", "ลาว", "ลัตเวีย", "เลบานอน", "เลโซโท", "ประเทศไลบีเรีย", "ประเทศลิบยา", "นสไตน์", "ประเทศลิธัวเนีย", "ลักเซมเบิร์ก", "มาเก๊า", "มาดากัสการ์", "มาลาวี", "ประเทศมาเลเซีย", "มัลดีฟส์", "มาลี", "เกาะมอลตา", "หมู่เกาะมาร์แชลล์", "มาร์ตินีก", "ประเทศมอริเตเนีย", "มอริเชียส", "มายอต", "เม็กซิโก", "ไมโครนีเซีย", "มอลโดวา", "โมนาโก", "ประเทศมองโกเลีย", "มอนเตเนโก", "มอนต์เซอร์รัต", "โมร็อกโก", "ประเทศโมซัมบิก", "พม่า", "นามิเบีย", "ประเทศนาอูรู", "ประเทศเนปาล", "เนเธอร์แลนด์", "นิวแคลิโดเนีย", "นิวซีแลนด์", "นิการากัว", "ประเทศไนเธอร์", "ประเทศไนจีเรีย", "นีอูเอ", "เกาะนอร์โฟล์ค", "เกาหลีเหนือ", "มาซิโดเนียตอนเหนือ", "หมู่เกาะมาเรียนาเหนือ", "นอร์เวย์", "โอมาน", "ปากีสถาน", "ปาเลา", "ปาเลสไตน์", "ปานามา", "ปาปัวนิวกินี", "ประเทศปารากวัย", "เปรู", "ฟิลิปปินส์", "หมู่เกาะพิตแคร์น", "โปแลนด์", "โปรตุเกส", "เปอร์โตริโก", "กาตาร์", "สาธารณรัฐคองโก", "โรมาเนีย", "รัสเซีย", "รวันดา", "ประชุม", "เซนต์บาร์เธเลมี", "เซนต์เฮเลน่า, แอสเซ็นชันและทริสตันดาคันฮา", "เซนต์คิตส์และเนวิส", "เซนต์ลูเซีย", "เซนต์มาร์ติน", "แซงปีแยร์และมีเกอลง", "เซนต์วินเซนต์และเกรนาดีนส์", "ซามัว", "ซานมาริโน", "ซาอุดิอาระเบีย", "ประเทศเซเนกัล", "เซอร์เบีย", "เซเชลส์", "เซียร์ราลีโอน", "สิงคโปร์", "เซนต์มาร์ติน", "สโลวะเกีย", "สโลวีเนีย", "หมู่เกาะโซโลมอน", "โซมาเลีย", "แอฟริกาใต้", "เซาท์จอร์เจีย", "เกาหลีใต้", "ซูดานใต้", "สเปน", "ศรีลังกา", "ซูดาน", "ซูรินาเม", "สฟาลบาร์และยานไมเอน", "สวีเดน", "ประเทศสวิสเซอร์แลนด์", "ซีเรีย", "เซาตูเมและปรินซิปี", "ไต้หวัน", "ทาจิกิสถาน", "ประเทศแทนซาเนีย", "ประเทศไทย", "ฝั่งตะวันตกและฉนวนกาซา", "ประเทศติมอร์ตะวันออก", "ไป", "โตเกเลา", "ตองกา", "ตรินิแดดและโตเบโก", "ตูนิเซีย", "ไก่งวง", "เติร์กเมนิสถาน", "หมู่เกาะเติกส์และหมู่เกาะเคคอส", "ตูวาลู", "ยูกันดา", "ยูเครน", "สหรัฐอาหรับเอมิเรตส์", "ประเทศอังกฤษ", "สหรัฐ", "เกาะเล็กรอบนอกของสหรัฐอเมริกา", "หมู่เกาะเวอร์จินของสหรัฐอเมริกา", "อุรุกวัย", "อุซเบกิ", "วานูอาตู", "เมืองวาติกัน", "เวเนซุเอลา", "เวียดนาม", "วอลลิซและฟูทานา", "ซาฮาร่าตะวันตก", "เยเมน", "แซมเบีย", "ประเทศซิมบับเว", "หมู่เกาะโอลันด์"]

  def self.rest_api(path)
    response = RestClient::Request.new({
      method: :get,
      url: "#{ENV['covid_api_host']}#{path}",
      timeout: 200
    }).execute do |response, request, result|
      return JSON.parse(CSV.parse(response.to_str, headers: true).map { |x| x.to_h }.to_json)
    end
  end

  def self.daily_reports_by_date(date = Date.yesterday)
    date_str = date.strftime('%m-%d-%Y')
    reports = rest_api("csse_covid_19_daily_reports/#{date_str}.csv")

    data = []
    reports.each do |report|
      province = report['Province/State'] || report['Province_State']
      country = report['Country/Region'] || report['Country_Region']
      updated_at = DateTime.parse(report['Last Update'] || report['Last_Update']).localtime
      confirmed = report['Confirmed'].to_i || 0
      deaths = report['Deaths'].to_i || 0
      recovered = report['Recovered'].to_i || 0
      active = report['Active'].to_i || 0
      latitude = report['Latitude'] || report['Lat']
      longitude = report['Longitude'] || report['Long_']

      country_id = ISO3166::Country.find_country_by_name(province)&.alpha2 || ISO3166::Country.find_country_by_name(country)&.alpha2

      time_difference = TimeDifference.between(updated_at, Time.now).in_general
      data << {
        country: country,
        country_id: country_id,
        province: province || nil,
        confirmed: confirmed,
        healings: ((confirmed - recovered) - deaths || 0).non_negative,
        deaths: deaths,
        recovered: recovered,
        active: active,
        latitude: latitude,
        longitude: longitude,
        updated_at: updated_at,
        last_updated: updated_at.to_difference_str,
      }
    end
    
    data
  end

  def self.daily_reports
    daily_reports_by_date
  end

  def self.total(date = Date.yesterday)
    resp = daily_reports_by_date(date)
    updated_at = resp.map{|h| h[:updated_at]}.max

    confirmed = resp.sum { |r| r[:confirmed].to_i }
    deaths = resp.sum { |r| r[:deaths].to_i }
    recovered = resp.sum { |r| r[:recovered].to_i }

    { 
      confirmed: confirmed || 0,
      healings: ((confirmed - recovered) - deaths || 0).non_negative,
      deaths: deaths || 0,
      recovered: recovered || 0,
      date: date,
      updated_at: updated_at,
      last_updated: updated_at.to_difference_str,
    }
  end

  def self.retroact(days = 6)
    data = {}

    ((Date.yesterday - days..Date.yesterday)).each do |date|
      data[date.strftime("%a")] = total(date)
    end

    data
  end

  def self.country(nation, date = Date.yesterday)
    nation = nation || 'TH'
    resp = daily_reports_by_date(date)

    nations = resp.select{ |r| r[:country_id] == nation.upcase }
    updated_at = nations.min_by{ |h| h[:updated_at] }[:updated_at]
    
    { 
      confirmed: nations.pluck(:confirmed).sum || 0,
      healings: nations.pluck(:healings).sum || 0,
      deaths: nations.pluck(:deaths).sum || 0,
      recovered: nations.pluck(:recovered).sum || 0,
      date: date,
      updated_at: updated_at,
      last_updated: updated_at.to_difference_str,
    }
  end

  def self.country_retroact(nation, days = 6)
    nation = nation || 'TH'
    data = {}

    ((Date.yesterday - days..Date.yesterday)).each do |date|
      data[date.strftime("%a")] = country(nation, date)
    end

    data
  end

  def self.api_workpoint(path)
    response = RestClient::Request.new({
      method: :get,
      url: "#{ENV['covid_workpoint_api_host']}#{path}.json",
      timeout: 200
    }).execute do |response, request, result|
      return JSON.parse(response.to_str)
    end
  end

  def self.constants
    response = api_workpoint('constants')
    date = Date.parse(response['เพิ่มวันที่'])

    {
      confirmed: response['ผู้ติดเชื้อ'].to_i,
      healings: response['กำลังรักษา'].to_i || 0,
      deaths: response['เสียชีวิต'].to_i || 0,
      recovered: response['หายแล้ว'].to_i || 0,
      confirmed_add_today: response['เพิ่มวันนี้'].to_i || 0,
      add_date: date,
      updated_at: DateTime.now.localtime,
      last_updated: "ข้อมูล ณ วันที่ #{I18n.l(date, format: '%d %B')}",
    }
  end

  def self.cases
    data = []
    response = api_workpoint('cases')

    response.each do |resp|
      statement_date = Date.parse(resp['statementDate'])
      recovered_date = nil
      recovered_date = Date.parse(resp['recoveredDate']) if resp['recoveredDate'].present?

      type = 'ไม่มีข้อมูล'
      type_color = "#000"

      case resp['type']
      when '1 - เดินทางมาจากประเทศกลุ่มเสี่ยง'  
        type_color = "#FE205D"
        type = "เดินทางมาจากประเทศ #{resp['meta'] || 'กลุ่มเสี่ยง'}"
      when '2 - ใกล้ชิดผู้เดินทางมาจากประเทศกลุ่มเสี่ยง'
        type_color = "#FE2099"
        type = 'ใกล้ชิดผู้เดินทางมาจาก ประเทศกลุ่มเสี่ยง'
      when '3 - ทราบผู้ป่วยแพร่เชื้อ (ไม่เข้าเกณฑ์ 1-2)'
        type_color = "#5920FE"
        type = 'ทราบผู้ป่วยแพร่เชื้อ'
      when '4 - ไม่ทราบผู้ป่วยแพร่เชื้อ (ไม่เข้าเกณฑ์ 1-2)'
        type_color = "#AD20FE"
        type = 'ไม่ทราบผู้ป่วยแพร่เชื้อ'
      end

      status = resp['status'] || 'ไม่มีข้อมูล'
      status_color = "#000"

      case status
      when 'รักษา'
        status_color = "#A2F202"
        status = 'กำลังรักษา'
      when 'หาย'
        status_color = "#01E35E"
        status = 'หายแล้ว'
      when 'เสียชีวิต'
        status_color = "#FC5E71"
      end

      data << {
        detected_at: resp['detectedAt'] || 'ไม่มีข้อมูล',
        origin: resp['origin'] || 'ไม่มีข้อมูล',
        treat_at: resp['treatAt'] || 'ไม่มีข้อมูล',
        status: status,
        status_color: status_color,
        job: resp['job'] || 'ไม่มีข้อมูล',
        gender: resp['gender'] || 'ไม่มีข้อมูล',
        age: resp['age'].to_i || 'ไม่มีข้อมูล',
        type: type,
        type_color: type_color,
        meta: resp['meta'],
        statement_date: statement_date,
        statement_date_str: I18n.l(statement_date, format: '%d %b'),
        recovered_date: recovered_date,
        recovered_date_str: recovered_date.present? ? I18n.l(recovered_date, format: '%d %b') : 'ไม่มีข้อมูล',
      }
    end

    data
  end

  def self.world
    total = Covid.total(Date.yesterday - 1.days)
    data = []
    response = api_workpoint('world')

    response['statistics'].sort_by { |hash| hash['name'].to_s }.each_with_index do |resp, index|
      travel = resp['travel'] || 'ยังไม่มีความเสี่ยง'
      travel_color = "#000"

      case travel
      when 'มีความเสี่ยง'
        travel_color = "#FED023"
      when 'ห้ามเดินทาง'
        travel_color = "#FE205D"
      end

      confirmed = resp['confirmed'].to_i || 0
      healings = ((resp['confirmed'].to_i - resp['recovered'].to_i ) - resp['deaths'].to_i || 0).non_negative
      deaths = resp['deaths'].to_i || 0
      recovered = resp['recovered'].to_i || 0

      data << {
        country: resp['name'],
        country_th: COUNTRY_TH[index],
        country_flag: "/#{resp['alpha2'].downcase}.png",
        confirmed: confirmed,
        confirmed_color: confirmed.to_covid_color,
        healings: healings,
        healings_color: healings.to_covid_color,
        deaths: deaths,
        deaths_color: deaths.to_covid_color,
        recovered: recovered,
        recovered_color: recovered.to_covid_color,
        travel: travel,
        travel_color: travel_color
      }
    end

    updated_at = DateTime.parse(response['lastUpdated']).localtime

    {
      confirmed: response['totalConfirmed'] || 0,
      add_today_count: (((response['totalConfirmed'] || 0) - total[:confirmed]) || 0).non_negative,
      healings: ((response['totalConfirmed'].to_i - response['totalRecovered'].to_i ) - response['totalDeaths'].to_i || 0).non_negative,
      deaths: response['totalDeaths'] || 0,
      recovered: response['totalRecovered'] || 0,
      statistics: data,
      updated_at: updated_at,
      last_updated: updated_at.to_difference_str,
    }
  end

  def self.save_world
    datas = world

    datas[:statistics].each do |data|
      world = World.find_by(country: data[:country])
      world = World.new if world.nil?
      world.country = data[:country]
      world.country_th = data[:country_th]
      world.country_flag = data[:country_flag]
      world.confirmed = data[:confirmed]
      world.healings = data[:healings]
      world.deaths = data[:deaths]
      world.recovered = data[:recovered]
      world.travel = data[:travel]

      world.save
    end
  end

  def self.trends
    api_workpoint('trend')
  end

  def self.summary_of_past_data(days = 6)
    data = {}
    trends = trends()

    ((Date.yesterday - days..Date.yesterday)).each do |date|
      trend = trends[date.to_year_month_day]

      next unless trend.present?
      data[date.strftime("%a")] = {
        confirmed: trend['confirmed'].to_i || 0,
        healings: (trend['confirmed'] - trend['recovered']) - trend['deaths'] || 0,
        deaths: trend['deaths'].to_i || 0,
        recovered: trend['recovered'].to_i || 0,
      }
    end

    data
  end

  def self.api_spreadsheets(path)
    response = RestClient::Request.new({
      method: :get,
      url: "#{ENV["covid_#{path}_host"]}",
      timeout: 200
    }).execute do |response, request, result|
      return JSON.parse(response.to_str)['feed']['entry']
    end
  end

  def self.cases_thai
    data = []
    response = api_spreadsheets('cases_thai')

    response.each do |resp|
      updated_at = DateTime.parse(resp['updated']['$t']).localtime
      begin
        date = Date.strptime(resp['gsx$date']['$t'], "%m/%d/%Y")
      rescue Exception
        date = DateTime.parse(resp['gsx$date']['$t'])
      end

      status_color = "#000"
      status = resp['gsx$status']['$t']

      case status
      when "ยืนยัน"
        status_color = "#00EC64"
      when "ต้องสงสัย" 
        status_color = "#9412F5"
      when "ไม่มีข้อมูลผู้ติดเชื้อพื้นที่"
        status_color = "#129FF5"
      when "ไม่ระบุพื้นที่"
        status_color = "#F55E12"
      end

      data << {
        status: status,
        status_color: status_color,
        date: date,
        date_diff_str: date.to_difference_str,
        place: resp['gsx$placename']['$t'],
        latitude: resp['gsx$lat']['$t'].to_f,
        longitude: resp['gsx$lng']['$t'].to_f,
        pin: '/red-zone-radius.svg'.to_map_pin,
        note: resp['gsx$note']['$t'],
        source: resp['gsx$source']['$t'],
        updated_at: updated_at,
        last_updated: updated_at.to_difference_str,
      }
    end

    data
  end

  def self.hospitals
    data = []
    response = api_spreadsheets('hospitals')

    response.each do |resp|
      updated_at = DateTime.parse(resp['updated']['$t']).localtime

      data << {
        name: resp['gsx$titleth']['$t'],
        name_eng: resp['gsx$titleother']['$t'],
        telephone: resp['gsx$tel']['$t'],
        price: resp['gsx$price']['$t'].present? ? resp['gsx$price']['$t'] : 'ไม่มีข้อมูล',
        latitude: resp['gsx$lat']['$t'].to_f,
        longitude: resp['gsx$lng']['$t'].to_f,
        pin: '/hospital-zone.svg'.to_map_pin,
        updated_at: updated_at,
        last_updated: updated_at.to_difference_str,
      }
    end

    data
  end

  def self.safe_zone
    data = []
    response = api_spreadsheets('safe_zone')

    response.each do |resp|
      updated_at = DateTime.parse(resp['updated']['$t']).localtime
      date = Date.parse(resp['gsx$date']['$t'])
      action_color = "#000"
      action = resp['gsx$action']['$t']

      case action
      when "ฆ่าเชื้อ"
        action_color = "#00EC64"
      when "ต้องสงสัย" 
        action_color = "#9412F5"
      when "ปิด"
        action_color = "#F51257"
      end

      data << {
        name: resp['gsx$area']['$t'],
        action: resp['gsx$action']['$t'],
        action_color: action_color,
        date: date,
        date_diff_str: date.to_difference_str,
        latitude: resp['gsx$lat']['$t'].to_f,
        longitude: resp['gsx$lng']['$t'].to_f,
        source: resp['gsx$source']['$t'],
        pin: '/sterilized-zone.svg'.to_map_pin,
        updated_at: updated_at,
        last_updated: updated_at.to_difference_str,
      }
    end

    data
  end

  def self.thai_summary
    data = []
    response = api_spreadsheets('thai_summary')

    response.each do |resp|
      updated_at = DateTime.parse(resp['updated']['$t']).localtime
      infected_color = "#000"
      infected = resp['gsx$infected']['$t'].to_i || 0

      data << {
        province: resp['gsx$provinceth']['$t'],
        province_eng: resp['gsx$provinceeng']['$t'],
        infected: infected,
        infected_color: infected.to_covid_color,
        updated_at: updated_at,
        last_updated: updated_at.to_difference_str,
      }
    end

    data
  end

  def self.api_hospital_lab
    response = RestClient::Request.new({
      method: :get,
      url: "#{ENV["covid_hospital_labs_host"]}",
      timeout: 200
    }).execute do |response, request, result|
      response_str = response.to_str
      response_str.gsub! 'var covid19 = ', ''

      return JSON.parse(response_str)['features']
    end
  end

  def self.hospital_and_labs
    data = []
    response = api_hospital_lab

    response.each do |resp|
      properties = resp['properties']

      data << {
        name: properties['NAME'],
        type: properties['TYPE'],
        source: properties['source'],
        pin: '/hospital-zone.svg'.to_map_pin,
        latitude: properties['Lat'].to_f,
        longitude: properties['Long'].to_f,
      }
    end

    data
  end

  def self.api_ddc
    RubyCheerio.new((RestClient.get ENV['covid_thai_ddc_host']).to_str)
  end

  def self.ddc_retry
    jQuery = api_ddc
    # Date
    date_time_str = jQuery.find('td.popup_hh').map { |td| td.text }.uniq.join(' ')
    updated_at = DateTime.strptime("#{date_time_str} +07:00", '%d %B %Y At %H:%M %Z').localtime

    return jQuery, date_time_str, updated_at
  end

  def self.thai_ddc
    begin
      jQuery, date_time_str, updated_at = ddc_retry
    rescue Exception
      jQuery, date_time_str, updated_at = ddc_retry
    end

    # Infected
    infected_keys = jQuery.find('td.popup_subhead').take(10).map.with_index do |td, index|
      case index
      when 0..4
        "Confirmed case #{td.text}".to_key
      when 5
        "PUI #{td.text}".to_key
      when 7..9
        "Case Management #{td.text}".to_key
      else
        td.text.to_key
      end
    end

    infected_values = jQuery.find('td.popup_num').take(infected_keys.count).map { |td| td.text.tap { |s| s.delete!(',') }.to_i }
    infecteds = Hash[infected_keys.zip(infected_values)]

    # Traveler
    traveler_keys = jQuery.find('td.popup_subhead2').map { |td| td.text.to_key }
    traveler_values = jQuery.find('td.popup_num2').take(traveler_keys.count).map { |td| td.text.tap { |s| s.delete!(',') }.to_i }
    travelers = Hash[traveler_keys.zip(traveler_values)]

    confirmed = infecteds['confirmed_case_total'].to_i || 0
    deaths = infecteds['confirmed_case_death'].to_i || 0
    recovered = infecteds['confirmed_case_discharged'].to_i || 0
    severed = infecteds['confirmed_case_severe'].to_i || 0

    {
      name: 'Corona Virus Disease (COVID-19)',
      country: 'Thailand',
      confirmed: confirmed,
      healings: ((confirmed - recovered) - deaths || 0).non_negative,
      deaths: deaths,
      recovered: recovered,
      critical: severed,
      confirmed_add_today: infecteds['confirmed_case_new_case'].to_i || 0,
      watch_out_collectors: infecteds['pui_total'].to_i || 0,
      new_watch_out: infecteds['new_pui'].to_i || 0,
      case_management_admit: infecteds['case_management_admit'].to_i || 0,
      case_management_discharged: infecteds['case_management_discharged'].to_i || 0,
      case_management_observation: infecteds['case_management_observation'].to_i || 0,
      airport: travelers['airport'].to_i || 0,
      sea_port: travelers['sea_port'].to_i || 0,
      ground_port: travelers['ground_port'].to_i || 0,
      at_chaeng_wattana: travelers['at_chaeng_wattana'].to_i || 0,
      date_time_str: date_time_str,
      updated_at: updated_at,
      last_updated: updated_at.to_difference_str,
      source: 'กรมควบคุมโรค Department of Disease Control',
      data_source: 'https://ddc.moph.go.th/viralpneumonia',
    }
  end

  def self.thai_separate_province
    response = GoogleApi.read
    updated_at = response[:updated_at]

    {
      name: 'จำนวนผู้ติดเชื้อแบบแยกจังหวัด',
      provinces: response[:provinces],
      updated_at: updated_at,
      last_updated: updated_at.to_difference_str,
    }
  end

  def self.api_ddc_global(url)
    response = RestClient::Request.new({
      method: :get,
      url: url,
      timeout: 200
    }).execute do |response, request, result|
      return JSON.parse(response.to_str)['features'].first['attributes']['value']
    end
  end

  def self.global_confirmed
    { 
      confirmed: api_ddc_global(ENV['covid_thai_ddc_global_confirmed_host'])
    }
  end

  def self.global_confirmed_add_today
    { 
      confirmed_add_today: api_ddc_global(ENV['covid_thai_ddc_global_confirmed_add_today_host'])
    }
  end

  def self.global_recovered
    { 
      recovered: api_ddc_global(ENV['covid_thai_ddc_global_recovered_host'])
    }
  end

  def self.global_critical
    { 
      critical: api_ddc_global(ENV['covid_thai_ddc_global_critical_host'])
    }
  end

  def self.global_deaths
    { 
      deaths: api_ddc_global(ENV['covid_thai_ddc_global_deaths_host'])
    }
  end

  def self.global_deaths_add_today
    { 
      deaths_add_today: api_ddc_global(ENV['covid_thai_ddc_global_deaths_add_today_host'])
    }
  end

  def self.api_arcgis_global(url)
    response = RestClient::Request.new({
      method: :get,
      url: url,
      headers: {
        authority: ENV['arcgis_authority'],
        referer: ENV['arcgis_referer']
      },
      timeout: 200
    }).execute do |response, request, result|
      return JSON.parse(response.to_str)['features'].first['attributes']['value']
    end
  end

  def self.global_summary
    total = Covid.total
    confirmed = Covid.api_arcgis_global(ENV['arcgis_global_confirmed_host'])

    yesterday = GlobalSummary.find_by(date: Date.yesterday)

    if total[:confirmed] > confirmed
      confirmed = total[:confirmed]
      recovered = total[:recovered]
      deaths = total[:deaths]
    else
      recovered = Covid.api_arcgis_global(ENV['arcgis_global_recovered_host'])
      deaths = Covid.api_arcgis_global(ENV['arcgis_global_deaths_host'])
    end

    confirmed_add_today = ((confirmed - yesterday.confirmed) || 0).non_negative
    deaths_add_today = ((deaths - yesterday.deaths) || 0).non_negative

    date = Date.today
    global_summary = GlobalSummary.find_by(date: date)
    global_summary = GlobalSummary.new if global_summary.nil?

    global_summary.date = date
    global_summary.confirmed = confirmed
    global_summary.confirmed_add_today = confirmed_add_today
    global_summary.healings = ((confirmed - recovered) - deaths || 0).non_negative
    global_summary.recovered = recovered
    begin
      global_summary.critical = Covid.global_critical[:critical]
    end
    global_summary.deaths = deaths
    global_summary.deaths_add_today = deaths_add_today

    global_summary.save
  end

  def self.global_summary_workpoint
    data = world

    date = Date.today
    global_summary = GlobalSummary.find_by(date: date)
    global_summary = GlobalSummary.new if global_summary.nil?

    global_summary.date = date
    global_summary.confirmed = data[:confirmed] if global_summary.confirmed < data[:confirmed]
    global_summary.healings = data[:healings] if global_summary.healings < data[:healings]
    global_summary.recovered = data[:recovered] if global_summary.recovered < data[:recovered]
    global_summary.deaths = data[:deaths] if global_summary.deaths < data[:deaths]

    global_summary.save
  end

  def self.api_thai_fight_covid
    RubyCheerio.new((RestClient.get 'https://thaifightcovid.depa.or.th/index.php').to_str)
  end

  def self.thai_fight_covid
    begin
      jQuery = api_thai_fight_covid
    rescue Exception
      jQuery = api_thai_fight_covid
    end

    thai_covid_data = {
      confirmed: 0,
      confirmed_add_today: 0,
      healings: 0,
      critical: 0,
      deaths: 0,
      recovered: 0,
      updated_at: nil,
      last_updated: nil
    }

    jQuery.find('div.info-box-4').each_with_index do |info_box, index|
      content = info_box.find('div.content').first
      if index.zero?
        date_str = content.find('div.text')[0].text
        updated_at = DateTime.strptime("#{date_str} +07:00", 'ข้อมูลล่าสุดวันที่ %d-%m-%Y').localtime - 543.year

        thai_covid_data[:updated_at] = updated_at
        thai_covid_data[:last_updated] = DateTime.now.to_difference_str
      else
        key = content.find('div.text')[0].text
        value = content.find('div.number')[0].text.to_i

        case key
        when 'จำนวนผู้ติดเชื้อ'
          thai_covid_data[:confirmed] = value
        when 'ผู้ป่วยกลับบ้านแล้ว'
          thai_covid_data[:recovered] = value
        when 'รายใหม่'
          thai_covid_data[:confirmed_add_today] = value
        when 'รุนแรง'
          thai_covid_data[:critical] = value
        when 'เสียชีวิต'
          thai_covid_data[:deaths] = value
        end
      end
    end

    thai_covid_data[:healings] = ((thai_covid_data[:confirmed] - thai_covid_data[:recovered]) - thai_covid_data[:deaths] || 0).non_negative

    thai_covid_data
  end

  def self.thailand_summary
    yesterday = ThailandSummary.find_by(date: Date.yesterday)
    workpoint = constants

    data = {}
    ddc = nil
    thai_covid = nil

    begin
      thai_covid = thai_fight_covid
      ddc = thai_ddc
      
      # use thai fight covid or workpoint
      if thai_covid[:confirmed] > ddc[:confirmed]
        ap "Use data >>> thai fight covid"
        data = thai_covid
      elsif workpoint[:confirmed] > ddc[:confirmed]
        ap "Use data >>> workpoint covid"
        data = workpoint
      else
        ap "Use data >>> ddc covid"
        data = ddc
      end
    rescue => e
      ap "Use data >>> workpoint covid"
      data = workpoint
    end


    date = Date.today
    thailand_summary = ThailandSummary.find_by(date: date)
    thailand_summary = ThailandSummary.new if thailand_summary.nil?

    thailand_summary.date = date
    thailand_summary.confirmed = data[:confirmed]
    thailand_summary.confirmed_add_today = data[:confirmed_add_today]
    thailand_summary.healings = data[:healings]
    thailand_summary.recovered = data[:recovered].zero? ? yesterday.recovered : data[:recovered]
    thailand_summary.deaths = data[:deaths]
    
    unless ddc.nil?
      thailand_summary.critical = data[:critical]
      thailand_summary.watch_out_collectors = data[:watch_out_collectors]
      thailand_summary.new_watch_out = data[:new_watch_out]
      thailand_summary.case_management_admit = data[:case_management_admit]
      thailand_summary.case_management_discharged = data[:case_management_discharged]
      thailand_summary.case_management_observation = data[:case_management_observation]
      thailand_summary.airport = data[:airport]
      thailand_summary.sea_port = data[:sea_port]
      thailand_summary.ground_port = data[:ground_port]
      thailand_summary.at_chaeng_wattana = data[:at_chaeng_wattana]
    end  

    thailand_summary.save
  end
end