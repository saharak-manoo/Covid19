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

  def self.daily_reports(date_str = Date.yesterday.strftime('%m-%d-%Y'))
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
        province: report[0],
        confirmed: report[3],
        deaths: report[4],
        recovered: report[5],
        updated_at: updated_at,
        last_updated: "ปรับปรุงล่าสุดเมื่อ #{time_difference[:hours]} ชั่วโมง #{time_difference[:minutes]} นาที #{time_difference[:seconds]} วินาที",
      }
    end
    
    data
  end

  def self.current
    daily_reports()
  end

  def self.confirmed
    resp = daily_reports()
    data = {}

  end

  def self.total
    rest_api("/total")
  end

  def self.total_confirmed
    rest_api("/confirmed")
  end

  def self.total_deaths
    rest_api("/deaths")
  end

  def self.total_recovered
    rest_api("/recovered")
  end

  def self.country(nation = 'th')
    rest_api("/country/#{nation}")
  end

  def self.timeseries_confirmed
    rest_api("/timeseries/confirmed")
  end

  def self.timeseries_deaths
    rest_api("/timeseries/deaths")
  end

  def self.timeseries_recovered
    rest_api("/timeseries/recovered")
  end
end