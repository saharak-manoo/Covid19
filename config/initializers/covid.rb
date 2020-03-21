class Covid
  CATEGORIES = ['Confirmed', 'Deaths', 'Recovered']

  def self.rest_api(path)
    response = RestClient::Request.new({
      method: :get,
      url: "#{ENV['covid_api_host']}#{path}"
    }).execute do |response, request, result|
      return JSON.parse(CSV.parse(response.to_str).to_json)
    end
  end

  def self.date_difference_str(date)
    date_difference = TimeDifference.between(date, Date.today).in_general

    date_difference[:days].zero? ? "วันนี้" : "#{date_difference[:days]} วันที่แล้ว"
  end

  def self.time_difference_str(updated_at)
    time_difference = TimeDifference.between(updated_at, Time.now).in_general
    last_updated = "ปรับปรุงล่าสุดเมื่อ "
    last_updated += "#{time_difference[:hours]} ชั่วโมง " unless time_difference[:hours].zero?
    last_updated += "#{time_difference[:minutes]} นาที" unless time_difference[:minutes].zero?
    last_updated += "ณ เวลานี้" if time_difference[:hours].zero? && time_difference[:minutes].zero?

    last_updated
  end

  def self.daily_reports_by_date(date = Date.yesterday)
    date_str = date.strftime('%m-%d-%Y')
    reports = rest_api("csse_covid_19_daily_reports/#{date_str}.csv")

    data = []
    reports.each_with_index do |report, index|
      next if index.zero?

      country_id = ISO3166::Country.find_country_by_name(report[0])&.alpha2 || ISO3166::Country.find_country_by_name(report[1])&.alpha2
      updated_at = DateTime.parse(report[2]).localtime
      time_difference = TimeDifference.between(updated_at, Time.now).in_general
      data << {
        country: report[1],
        country_id: country_id,
        province: report[0] || 0,
        confirmed: report[3].to_i || 0,
        healings: (report[3].to_i - report[5].to_i) - report[4].to_i || 0,
        deaths: report[4].to_i || 0,
        recovered: report[5].to_i || 0,
        updated_at: updated_at,
        last_updated: time_difference_str(updated_at),
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
      last_updated: time_difference_str(updated_at),
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
      last_updated: time_difference_str(updated_at),
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
      url: "#{ENV['covid_workpoint_api_host']}#{path}"
    }).execute do |response, request, result|
      return JSON.parse(response.to_str)
    end
  end

  def self.constants
    response = api_workpoint('constants')

    {
      confirmed: response['ผู้ติดเชื้อ'],
      healings: response['กำลังรักษา'] || 0,
      deaths: response['เสียชีวิต'] || 0,
      recovered: response['หายแล้ว'] || 0,
      add_today_count: response['เพิ่มวันนี้'] || 0,
      add_date: Date.parse(response['เพิ่มวันที่']),
      updated_at: DateTime.now.localtime,
      last_updated: time_difference_str(DateTime.now.localtime),
    }
  end

  def self.cases
    data = []
    response = api_workpoint('cases')

    response.each do |resp|
      type = 'ไม่มีข้อมูล'
      type_color = "#000"

      case resp['type']
      when '1 - เดินทางมาจากประเทศกลุ่มเสี่ยง'  
        type_color = "#FE205D"
        type = 'เดินทางมาจากประเทศกลุ่มเสี่ยง'
      when '2 - ใกล้ชิดผู้เดินทางมาจากประเทศกลุ่มเสี่ยง'
        type_color = "#FE2099"
        type = 'ใกล้ชิดผู้เดินทางมาจากประเทศกลุ่มเสี่ยง'
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
        age: resp['age'] || 'ไม่มีข้อมูล',
        type: type,
        type_color: type_color
      }
    end

    data
  end

  def self.world
    data = []
    response = api_workpoint('world')

    response['statistics'].each do |resp|
      travel = resp['travel'] || 'ยังไม่มีความเสี่ยง'
      travel_color = "#000"

      case travel
      when 'มีความเสี่ยง'
        travel_color = "#FED023"
      when 'ห้ามเดินทาง'
        travel_color = "#FE205D"
      end

      data << {
        country: resp['name'],
        country_flag: "/#{resp['alpha2'].downcase}.png",
        confirmed: resp['confirmed'] || 0,
        healings: (resp['confirmed'].to_i - resp['recovered'].to_i ) - resp['deaths'].to_i || 0,
        deaths: resp['deaths'] || 0,
        recovered: resp['recovered'] || 0,
        travel: travel,
        travel_color: travel_color
      }
    end

    updated_at = DateTime.parse(response['lastUpdated']).localtime

    {
      confirmed: response['totalConfirmed'] || 0,
      healings: (response['totalConfirmed'].to_i - response['totalRecovered'].to_i ) - response['totalDeaths'].to_i || 0,
      deaths: response['totalDeaths'] || 0,
      recovered: response['totalRecovered'] || 0,
      statistics: data,
      updated_at: updated_at,
      last_updated: time_difference_str(updated_at),
    }
  end

  def self.trends
    api_workpoint('trend')
  end

  def self.summary_of_past_data(days = 6)
    data = {}
    trends = trends()

    ((Date.yesterday - days..Date.yesterday)).each do |date|
      trend = trends[date.strftime("%Y-%m-%d")]

      next unless trend.present?
      data[date.strftime("%a")] = {
        confirmed: trend['confirmed'] || 0,
        healings: (trend['confirmed'] - trend['recovered']) - trend['deaths'] || 0,
        deaths: trend['deaths'] || 0,
        recovered: trend['recovered'] || 0,
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
      date = Date.strptime(resp['gsx$date']['$t'], "%m/%d/%Y")
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
        date_diff_str: date_difference_str(date),
        place: resp['gsx$placename']['$t'],
        province: resp['gsx$province']['$t'],
        placename_eng: resp['gsx$placenameeng']['$t'],
        latitude: resp['gsx$lat']['$t'].to_f,
        longitude: resp['gsx$lng']['$t'].to_f,
        pin: map_pin('/red-zone-radius.svg'),
        note: resp['gsx$note']['$t'],
        source: resp['gsx$source']['$t'],
        updated_at: updated_at,
        last_updated: time_difference_str(updated_at),
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
        pin: map_pin('/hospital-zone.svg'),
        updated_at: updated_at,
        last_updated: time_difference_str(updated_at),
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
        date_diff_str: date_difference_str(date),
        latitude: resp['gsx$lat']['$t'].to_f,
        longitude: resp['gsx$lng']['$t'].to_f,
        source: resp['gsx$source']['$t'],
        pin: map_pin('/sterilized-zone.svg'),
        updated_at: updated_at,
        last_updated: time_difference_str(updated_at),
      }
    end

    data
  end

  def self.thai_summary
    data = []
    response = api_spreadsheets('thai_summary')

    response.each do |resp|
      updated_at = DateTime.parse(resp['updated']['$t']).localtime

      data << {
        province: resp['gsx$provinceth']['$t'],
        province_eng: resp['gsx$provinceeng']['$t'],
        infected: resp['gsx$infected']['$t'].to_i || 0,
        updated_at: updated_at,
        last_updated: time_difference_str(updated_at),
      }
    end

    data
  end

  def self.map_pin(image)
    {
      url: image,
      scaledSize: {
        width: 30,
        height: 30
      }
    }
  end  
end