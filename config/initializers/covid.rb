class Covid
  CATEGORIES = ['Confirmed', 'Deaths', 'Recovered']
  COUNTRY_TH = ["ประเทศไทย", "ประเทศญี่ปุ่น", "สิงคโปร์", "ประเทศเนปาล", "ประเทศมาเลเซีย", "แคนาดา", "ออสเตรเลีย", "กัมพูชา", "ศรีลังกา", "ประเทศเยอรมัน", "ฟินแลนด์", "สหรัฐอาหรับเอมิเรตส์", "ฟิลิปปินส์", "อินเดีย", "อิตาลี", "สวีเดน", "สเปน", "เบลเยียม", "อียิปต์", "เลบานอน", "อิรัก", "โอมาน", "อัฟกานิสถาน", "บาห์เรน", "คูเวต", "แอลจีเรีย", "โครเอเชีย", "ประเทศสวิสเซอร์แลนด์", "ออสเตรีย", "อิสราเอล", "ปากีสถาน", "บราซิล", "จอร์เจีย", "กรีซ", "มาซิโดเนียตอนเหนือ", "นอร์เวย์", "โรมาเนีย", "เอสโตเนีย", "ซานมาริโน", "เบลารุส", "ประเทศไอซ์แลนด์", "ประเทศลิธัวเนีย", "เม็กซิโก", "นิวซีแลนด์", "ประเทศไนจีเรีย", "ไอร์แลนด์", "ลักเซมเบิร์ก", "โมนาโก", "กาตาร์", "เอกวาดอร์", "อาเซอร์ไบจาน", "อาร์เมเนีย", "สาธารณรัฐโดมินิกัน", "อินโดนีเซีย", "โปรตุเกส", "อันดอร์รา", "ลัตเวีย", "โมร็อกโก", "ซาอุดิอาระเบีย", "ประเทศเซเนกัล", "อาร์เจนตินา", "ชิลี", "จอร์แดน", "ยูเครน", "ฮังการี", "นสไตน์", "โปแลนด์", "ตูนิเซีย", "บอสเนียและเฮอร์เซโก", "สโลวีเนีย", "แอฟริกาใต้", "ภูฏาน", "แคเมอรูน", "โคลอมเบีย", "คอสตาริกา", "เปรู", "เซอร์เบีย", "สโลวะเกีย", "ไป", "เกาะมอลตา", "มาร์ตินีก", "บัลแกเรีย", "มัลดีฟส์", "บังคลาเทศ", "ประเทศปารากวัย", "แอลเบเนีย", "ประเทศไซปรัส", "บรูไน", "สหรัฐ", "บูร์กินาฟาโซ", "เมืองวาติกัน", "ประเทศมองโกเลีย", "ปานามา", "ประเทศจีน", "อิหร่าน", "เกาหลีใต้", "ฝรั่งเศส", "เรือสำราญ", "เดนมาร์ก", "เช็ก", "ไต้หวัน", "เวียดนาม", "รัสเซีย", "มอลโดวา", "โบลิเวีย", "ฮอนดูรัส", "ประเทศอังกฤษ", "สาธารณรัฐคองโก", "ชายฝั่งงาช้าง", "เกาะจาเมกา", "ไก่งวง", "คิวบา", "กายอานา", "คาซัคสถาน", "สาธารณรัฐเอธิโอเปีย", "ซูดาน", "ประเทศกินี", "ประเทศเคนย่า", "แอนติกาและบาร์บูดา", "อุรุกวัย", "ประเทศกานา", "นามิเบีย", "เซเชลส์", "ตรินิแดดและโตเบโก", "เวเนซุเอลา", "สวาซิแลนด์", "ประเทศกาบอง", "กัวเตมาลา", "ประเทศมอริเตเนีย", "รวันดา", "เซนต์ลูเซีย", "เซนต์วินเซนต์และเกรนาดีนส์", "ซูรินาเม", "โคโซโว", "สาธารณรัฐอัฟริกากลาง", "สาธารณรัฐคองโก", "อิเควทอเรียลกินี", "อุซเบกิ", "เนเธอร์แลนด์", "ประเทศเบนิน", "ประเทศไลบีเรีย", "โซมาเลีย", "ประเทศแทนซาเนีย", "บาร์เบโดส", "มอนเตเนโก", "คีร์กีสถาน", "มอริเชียส", "แซมเบีย", "จิบูตี", "แกมเบีย", "บาฮามาส", "ชาด", "เอลซัลวาดอร์", "ฟิจิ", "นิการากัว", "มาดากัสการ์", "ไฮติ", "แองโกลา", "เคปเวิร์ด", "ประเทศไนเธอร์", "ปาปัวนิวกินี", "ประเทศซิมบับเว", "ติมอร์ตะวันออก", "เอริเทรี", "ยูกันดา", "โดมินิกา", "เกรเนดา", "ประเทศโมซัมบิก", "ซีเรีย", "ประเทศติมอร์ตะวันออก", "อารูบา", "แองกวิลลา", "หมู่เกาะโอลันด์", "อเมริกันซามัว", "ทวิปแอนตาร์กติกา", "ดินแดนทางใต้ของฝรั่งเศสและแอนตาร์กติก", "บุรุนดี", "เซนต์บาร์เธเลมี", "เซนต์เฮเลน่า, แอสเซ็นชันและทริสตันดาคันฮา", "เบลีซ", "เบอร์มิวดา", "แคริบเบียนเนเธอร์แลนด์", "เกาะบูเวต", "บอตสวานา", "หมู่เกาะโคโคส (คีลิง)", "หมู่เกาะคุก", "คอโมโรส", "คูราเซา", "เกาะคริสต์มาส", "หมู่เกาะเคย์เเมน", "ซาฮาร่าตะวันตก", "หมู่เกาะฟอล์คแลนด์", "หมู่เกาะแฟโร", "ไมโครนีเซีย", "เสื้อไหมพรม", "ยิบรอลตา", "ลุป", "กินีบิสเซา", "เกาะกรีนแลนด์", "เฟรนช์เกีย", "กวม", "ฮ่องกง", "เกาะ Heard และ McDonald Islands", "ไอล์ออฟแมน", "เขตมหาสมุทรบริติชอินเดีย", "นิวเจอร์ซีย์", "ประเทศคิริบาส", "เซนต์คิตส์และเนวิส", "ลาว", "ประเทศลิบยา", "เลโซโท", "มาเก๊า", "เซนต์มาร์ติน", "หมู่เกาะมาร์แชลล์", "มาลี", "พม่า", "หมู่เกาะมาเรียนาเหนือ", "มอนต์เซอร์รัต", "มาลาวี", "มายอต", "นิวแคลิโดเนีย", "เกาะนอร์โฟล์ค", "นีอูเอ", "ประเทศนาอูรู", "หมู่เกาะพิตแคร์น", "ปาเลา", "เปอร์โตริโก", "เกาหลีเหนือ", "ปาเลสไตน์", "เฟรนช์โปลินีเซีย", "ประชุม", "เซาท์จอร์เจีย", "สฟาลบาร์และยานไมเอน", "หมู่เกาะโซโลมอน", "เซียร์ราลีโอน", "แซงปีแยร์และมีเกอลง", "ซูดานใต้", "เซาตูเมและปรินซิปี", "เซนต์มาร์ติน", "หมู่เกาะเติกส์และหมู่เกาะเคคอส", "ทาจิกิสถาน", "โตเกเลา", "เติร์กเมนิสถาน", "ตองกา", "ตูวาลู", "หมู่เกาะเล็กรอบนอกของสหรัฐอเมริกา", "หมู่เกาะบริติชเวอร์จิน", "หมู่เกาะเวอร์จินของสหรัฐอเมริกา", "วานูอาตู", "วอลลิซและฟูทานา", "ซามัว", "เยเมน"]

  def self.rest_api(path)
    response = RestClient::Request.new({
      method: :get,
      url: "#{ENV['covid_api_host']}#{path}"
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
        healings: (confirmed - recovered) - deaths || 0,
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
      healings: (confirmed - recovered) - deaths || 0,
      deaths: deaths || 0,
      recovered: recovered || 0,
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
      url: "#{ENV['covid_workpoint_api_host']}#{path}.json"
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
      add_today_count: response['เพิ่มวันนี้'].to_i || 0,
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

    response['statistics'].each_with_index do |resp, index|
      travel = resp['travel'] || 'ยังไม่มีความเสี่ยง'
      travel_color = "#000"

      case travel
      when 'มีความเสี่ยง'
        travel_color = "#FED023"
      when 'ห้ามเดินทาง'
        travel_color = "#FE205D"
      end

      confirmed = resp['confirmed'].to_i || 0
      healings = (resp['confirmed'].to_i - resp['recovered'].to_i ) - resp['deaths'].to_i || 0
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
      add_today_count: ((response['totalConfirmed'] || 0) - total[:confirmed]) || 0,
      healings: (response['totalConfirmed'].to_i - response['totalRecovered'].to_i ) - response['totalDeaths'].to_i || 0,
      deaths: response['totalDeaths'] || 0,
      recovered: response['totalRecovered'] || 0,
      statistics: data,
      updated_at: updated_at,
      last_updated: updated_at.to_difference_str,
    }
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
      url: "#{ENV["covid_#{path}_host"]}"
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
      url: "#{ENV["covid_hospital_labs_host"]}"
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
      healings: (confirmed - recovered) - deaths || 0,
      deaths: deaths,
      recovered: recovered,
      severed: severed,
      add_today_count: infecteds['confirmed_case_new_case'].to_i || 0,
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
      url: url
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

  def self.global_summary
    updated_at = DateTime.now.localtime
    confirmed = api_ddc_global(ENV['covid_thai_ddc_global_confirmed_host'])
    confirmed_add_today = api_ddc_global(ENV['covid_thai_ddc_global_confirmed_add_today_host'])
    recovered = api_ddc_global(ENV['covid_thai_ddc_global_recovered_host'])
    critical = api_ddc_global(ENV['covid_thai_ddc_global_critical_host'])
    deaths = api_ddc_global(ENV['covid_thai_ddc_global_deaths_host'])
    deaths_add_today = api_ddc_global(ENV['covid_thai_ddc_global_deaths_add_today_host'])

    { 
      confirmed: confirmed,
      confirmed_add_today: confirmed_add_today,
      healings: (confirmed - recovered) - deaths || 0,
      recovered: recovered,
      critical: critical,
      deaths: deaths,
      deaths_add_today: deaths_add_today,
      updated_at: updated_at,
      last_updated: updated_at.to_difference_str,
    }
  end

  def self.test
    url_list = [ENV['covid_thai_ddc_global_confirmed_host'], ENV['covid_thai_ddc_global_confirmed_add_today_host'], ENV['covid_thai_ddc_global_recovered_host'], ENV['covid_thai_ddc_global_critical_host'], ENV['covid_thai_ddc_global_deaths_host'], ENV['covid_thai_ddc_global_deaths_add_today_host']]
    responses = []

    url_list.each do |url|
      responses << api_ddc_global(url)
    end

    responses
  end  
end