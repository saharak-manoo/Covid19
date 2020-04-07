class Covid
  CATEGORIES = ['Confirmed', 'Deaths', 'Recovered']
  PROVINCE_TH = [
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงใหม่',
    'เชียงราย',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พะเยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี',
  ]
  
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
    date = Date.parse(response['เพิ่มวันที่']) rescue nil

    {
      confirmed: response['ผู้ติดเชื้อ'].to_i,
      healings: response['กำลังรักษา'].to_i || 0,
      deaths: response['เสียชีวิต'].to_i || 0,
      recovered: response['หายแล้ว'].to_i || 0,
      confirmed_add_today: response['เพิ่มวันนี้'].to_i || 0,
      add_date: date,
      updated_at: DateTime.now.localtime,
      last_updated: date.present? ? "ข้อมูล ณ วันที่ #{I18n.l(date, format: '%d %B')}" : 'ไม่มีข้อมูล',
    }
  end

  def self.cases
    data = []
    response = api_workpoint('cases')

    response.each do |resp|
      statement_date = Date.parse(resp['statementDate']) rescue nil
      recovered_date = Date.parse(resp['recoveredDate']) rescue nil

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
        country_th: World.find_by(country: resp['name'])&.country_th || resp['name'],
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
    begin
      datas = world
    rescue => e
      datas = nil
      LineNoti.send_to_dev("ไม่สามารถสร้างหรือแก้ไขข้อมูล World ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
    end

    unless datas.nil?
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

      status = resp['gsx$status']['$t']

      data << {
        status: status,
        date: date,
        date_diff_str: date.to_difference_str,
        place: resp['gsx$placename']['$t'],
        latitude: resp['gsx$lat']['$t'].to_f,
        longitude: resp['gsx$lng']['$t'].to_f,
        pin: '/confirmed.svg'.to_map_pin,
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
      infected = resp['gsx$infected']['$t'].to_i || 0
      province = resp['gsx$provinceth']['$t']
      province = 'กรุงเทพมหานคร' if province == 'กรุงเทพฯ'

      data << {
        province: province,
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
    infected_keys = jQuery.find('td.popup_subhead').take(6).map.with_index do |td, index|
      case index
      when 0..3
        "Confirmed case #{td.text}".to_key
      when 4..5
        "PUI #{td.text}".to_key
      end
    end

    infected_values = jQuery.find('td.popup_num').take(infected_keys.count).map { |td| td.text.tap { |s| s.delete!(',') }.to_i }
    infecteds = Hash[infected_keys.zip(infected_values)]

    # Traveler
    traveler_keys = jQuery.find('td.popup_subhead2').map { |td| td.text.to_key }
    traveler_values = jQuery.find('td.popup_num2').take(traveler_keys.count).map { |td| td.text.tap { |s| s.delete!(',') }.to_i }
    travelers = Hash[traveler_keys.zip(traveler_values)]

    confirmed = infecteds['confirmed_case_total'].to_i || 0
    deaths = infecteds['confirmed_case_deaths'].to_i || 0
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
      new_watch_out: infecteds['pui_new_pui'].to_i || 0,
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
    api_ddc_global(ENV['covid_thai_ddc_global_confirmed_host'])
  end

  def self.global_confirmed_add_today
    api_ddc_global(ENV['covid_thai_ddc_global_confirmed_add_today_host'])
  end

  def self.global_recovered
    api_ddc_global(ENV['covid_thai_ddc_global_recovered_host'])
  end

  def self.global_critical
    api_ddc_global(ENV['covid_thai_ddc_global_critical_host'])
  end

  def self.global_deaths
    api_ddc_global(ENV['covid_thai_ddc_global_deaths_host'])
  end

  def self.global_deaths_add_today
    api_ddc_global(ENV['covid_thai_ddc_global_deaths_add_today_host'])
  end

  def self.global_by_ddc
    begin
      yesterday = GlobalSummary.find_by(date: Date.yesterday)
      date = Date.today
      global_summary = GlobalSummary.find_by(date: date)
      global_summary = GlobalSummary.new if global_summary.nil?

      confirmed = global_confirmed
      confirmed_add_today = ((confirmed - yesterday.confirmed) || 0).non_negative
      recovered = global_recovered
      deaths = global_deaths
      deaths_add_today = ((deaths - yesterday.deaths) || 0).non_negative

      global_summary.date = global_summary.date != date ? global_summary.date : date
      global_summary.confirmed = confirmed || 0
      global_summary.confirmed_add_today = confirmed_add_today
      global_summary.healings = ((confirmed - recovered) - deaths || 0).non_negative
      global_summary.recovered = global_recovered || 0
      global_summary.critical = global_critical || 0
      global_summary.deaths = deaths
      global_summary.deaths_add_today = deaths_add_today || 0
      global_summary.save
      
      global_summary
    rescue ActiveRecord::ConnectionNotEstablished
      # ไม่มีอะไร Updated
    rescue => e
      LineNoti.send_to_dev("ไม่สามารถ เรียกใช้ข้อมูลจากกรมกักกันโรคได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
      self.global_summary
    end
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
    begin
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
      global_summary.confirmed = confirmed || 0
      global_summary.confirmed_add_today = confirmed_add_today || 0
      global_summary.healings = ((confirmed - recovered) - deaths || 0).non_negative
      global_summary.recovered = recovered || 0
      begin
        global_summary.critical = global_critical || 0
      end
      global_summary.deaths = deaths || 0
      global_summary.deaths_add_today = deaths_add_today || 0
      global_summary.save

      global_summary
    rescue ActiveRecord::ConnectionNotEstablished
      # ไม่มีอะไร Updated
    rescue => e
      LineNoti.send_to_dev("ไม่สามารถสร้างหรือแก้ไขข้อมูล global summary ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
    end
  end

  def self.global_summary_workpoint
    begin
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

      global_summary
    rescue ActiveRecord::ConnectionNotEstablished
      # ไม่มีอะไร Updated
    rescue => e
      LineNoti.send_to_dev("ไม่สามารถสร้างหรือแก้ไขข้อมูล global summary workpoint api ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
    end
  end

  def self.api_thai_fight_covid
    RubyCheerio.new((RestClient.get ENV['thai_fight_covid_host']).to_str)
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
    }

    jQuery.find('div.info-box-4').each_with_index do |info_box, index|
      content = info_box.find('div.content').first
      unless index.zero?
        key = content.find('div.text')[0].text
        value = content.find('div.number')[0].text.tap { |s| s.delete!(',') }.to_i

        case key
        when 'จำนวนผู้ติดเชื้อ'
          thai_covid_data[:confirmed] = value
        when 'หายแล้ว'
          thai_covid_data[:recovered] = value
        when 'รายใหม่'
          thai_covid_data[:confirmed_add_today] = value
        when 'รักษาอยู่ใน รพ.'
          thai_covid_data[:healings] = value
        when 'เสียชีวิต'
          thai_covid_data[:deaths] = value
        end
      end
    end

    thai_covid_data[:healings] = ((thai_covid_data[:confirmed] - thai_covid_data[:recovered]) - thai_covid_data[:deaths] || 0).non_negative

    thai_covid_data
  end

  def self.api_covid19_thailand(path)
    response = RestClient::Request.new({
      method: :get,
      url: "#{ENV['covid19_api_th_host']}#{path}",
      timeout: 200
    }).execute do |response, request, result|
      return JSON.parse(response.to_str)
    end
  end

  def self.thailand_today
    resp = api_covid19_thailand('today')
    updated_at = DateTime.parse(resp['UpdateDate']).localtime rescue nil

    {
      confirmed: resp['Confirmed'] || 0,
      confirmed_add_today: resp['NewConfirmed'] || 0,
      healings: resp['Hospitalized'] || 0,
      healings_add_today: resp['NewHospitalized'] || 0,
      deaths: resp['Deaths'] || 0,
      deaths_add_today: resp['NewDeaths'] || 0,
      recovered: resp['Recovered'] || 0,
      recovered_add_today: resp['NewRecovered'] || 0,
      updated_at: updated_at,
      last_updated: updated_at&.to_difference_str,
    }
  end

  def self.thailand_timeline
    data_timelines = []
    timelines = api_covid19_thailand('timeline')

    timelines['Data'].each do |timeline|
      date = Date.strptime(timeline['Date'], '%m/%d/%Y') rescue nil

      data_timelines << {
        date: date,
        date_str: date.present? ? date.strftime('%d/%m/%Y') : '-',
        date_short_thai_str: date.present? ? I18n.l(date, format: '%d %b') : '-',
        date_thai_str: date.present? ? I18n.l(date, format: '%d %B %Y') : '-',
        confirmed: (timeline['Confirmed'] || 0).non_negative,
        confirmed_add_today: (timeline['NewConfirmed'] || 0).non_negative,
        healings: (timeline['Hospitalized'] || 0.non_negative),
        healings_add_today: (timeline['NewHospitalized'] || 0).non_negative,
        deaths: (timeline['Deaths'] || 0).non_negative,
        deaths_add_today: (timeline['NewDeaths'] || 0).non_negative,
        recovered: (timeline['Recovered'] || 0).non_negative,
        recovered_add_today: (timeline['NewRecovered'] || 0).non_negative
      }
    end

    data_timelines
  end

  def self.thailand_area
    data_areas = []
    areas = api_covid19_thailand('area')

    areas['Data'].each do |area|
      date = area['Date'].difference_language_to_date rescue nil
      updated_at = DateTime.parse(area['Update']).localtime rescue nil

      data_areas << {
        date: date,
        date_str: date.to_difference_str,
        detail: area['Detail'].gsub(/<\/?[^>]+>/, '').gsub(/&nbsp;/i, " ").strip,
        location: area['Location'].gsub(/<\/?[^>]+>/, '').gsub(/&nbsp;/i, " ").strip,
        recommend: area['Recommend'].gsub(/<\/?[^>]+>/, '').gsub(/&nbsp;/i, " ").strip,
        announce_by: area['AnnounceBy'].gsub(/<\/?[^>]+>/, '').gsub(/&nbsp;/i, " ").strip,
        province: area['Province'],
        province_eng: area['ProvinceEn'],
        updated_at: updated_at,
        last_updated: updated_at&.to_difference_str,
      }
    end

    data_areas
  end  

  def self.thailand_summary
    yesterday = ThailandSummary.find_by(date: Date.yesterday)
    hash = []
    ddc = thai_ddc rescue nil

    begin
      thai_covid = thai_fight_covid
      hash << {
        key: 'thai_covid', 
        confirmed: thai_covid[:confirmed] || 0,
        recovered: thai_covid[:recovered] || 0,  
        deaths: thai_covid[:deaths] || 0, 
        data: thai_covid
      }
    rescue => e
      thai_covid = nil
    end

    begin
      thail_today = thailand_today
      hash << {
        key: 'thail_today', 
        confirmed: thail_today[:confirmed] || 0,
        recovered: thail_today[:recovered] || 0,  
        deaths: thail_today[:deaths] || 0, 
        data: thail_today
      }
    rescue => e
      thail_today = nil
    end

    data = {}
    data = hash.max_by{ |h| h[:confirmed] }[:data]

    begin
      date = Date.today
      thailand_summary = ThailandSummary.find_by(date: date)
      thailand_summary = ThailandSummary.new if thailand_summary.nil?

      thailand_summary.date = date
      thailand_summary.confirmed = data[:confirmed] || 0
      thailand_summary.confirmed_add_today = data[:confirmed_add_today] || 0
      thailand_summary.healings = data[:healings] || 0
      thailand_summary.recovered = data[:recovered].zero? ? yesterday.recovered || 0 : data[:recovered] || 0
      thailand_summary.deaths = data[:deaths] || 0

      unless ddc.nil?
        thailand_summary.critical = ddc[:critical] || 0
        thailand_summary.watch_out_collectors = ddc[:watch_out_collectors] || 0
        thailand_summary.new_watch_out = ddc[:new_watch_out] || 0
        thailand_summary.airport = ddc[:airport] || 0
        thailand_summary.sea_port = ddc[:sea_port] || 0
        thailand_summary.ground_port = ddc[:ground_port] || 0
        thailand_summary.at_chaeng_wattana = ddc[:at_chaeng_wattana] || 0
      end  

      thailand_summary.save
      thailand_summary
    rescue ActiveRecord::ConnectionNotEstablished
      # ไม่มีอะไร Updated
    rescue => e
      LineNoti.send_to_dev("ไม่สามารถสร้างหรือแก้ไขข้อมูล thailand summary ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
    end
  end

  def self.v2_cases
    cases = []
    cases_response = api_workpoint('v2/cases')

    cases_response['records'].each do |record|
      statement_date = Date.parse(record['statementDate']) rescue nil
      detected_date = Date.parse(record['detectedDate']) rescue nil

      province = record['province']
      province = 'กรุงเทพมหานคร' if province == 'กทม'

      cases << {
        gender: record['gender'] || '-',
        age: record['age'] || '-',
        age_color: (record['age'] || 0).to_age_covid_color,
        ageMonth: record['ageMonth'] || '-',
        job: record['job'] || '-',
        nationality: record['nationality'] || '-',
        nationality_alpha2: record['nationalityAlpha2'] || '-',
        province: province || '-',
        district: record['district'] || '-',
        risk: record['risk'] || '-',
        statement_date: statement_date || '-',
        statement_date_str: statement_date.present? ? I18n.l(statement_date, format: '%d %b') : '-',
        detected_date: detected_date || '-',
        detected_date_str: detected_date.present? ? I18n.l(detected_date, format: '%d %b') : '-',
      }
    end

    cases
  end

  def self.thailand_infected_province
    cases = v2_cases

    PROVINCE_TH.each do |name|
      begin
        province_cases = cases.select { |c| c[:province] == name }
        infected = province_cases.count || 0
        man_total = province_cases.select { |c| c[:gender] == 'ชาย' }.count || 0
        woman_total = province_cases.select { |c| c[:gender] == 'หญิง' }.count || 0
        no_gender_total = province_cases.select { |c| c[:gender] == '-' }.count || 0
        
        date = Date.today
        infected_province = InfectedProvince.find_by(date: date, name: name)
        infected_province = InfectedProvince.new if infected_province.nil?

        infected_province.date = date
        infected_province.name = name
        infected_province.infected = infected
        infected_province.man_total = man_total
        infected_province.woman_total = woman_total
        infected_province.no_gender_total = no_gender_total

        infected_province.save
        infected_province
      rescue ActiveRecord::ConnectionNotEstablished
        # ไม่มีอะไร Updated
      rescue => e
        LineNoti.send_to_dev("ไม่สามารถสร้างหรือแก้ไขข้อมูล Infected province ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
      end
    end
  end

  def self.save_thailand_cases
    cases = cases_thai

    cases.each do |case_thai|
      begin
        thailand_case = ThailandCase.find_by(place_name: case_thai[:place])
        thailand_case = ThailandCase.new if thailand_case.nil?

        thailand_case.place_name = case_thai[:place]
        thailand_case.date = case_thai[:date]
        thailand_case.status = case_thai[:status]
        thailand_case.note = case_thai[:note]
        thailand_case.source = case_thai[:source]
        thailand_case.latitude = case_thai[:latitude]
        thailand_case.longitude = case_thai[:longitude]

        thailand_case.save
        thailand_case
      rescue ActiveRecord::ConnectionNotEstablished
        # ไม่มีอะไร Updated
      rescue => e
        LineNoti.send_to_dev("ไม่สามารถสร้างหรือแก้ไขข้อมูล Thailand Infected case ได้ \n Exception #{e.class.name} \n Error message => #{e.message}")
      end
    end
  end
end
