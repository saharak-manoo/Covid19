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

  def self.daily_reports
    daily_reports_by_date
  end

  def self.total
    resp = daily_reports_by_date
    updated_at = resp.map{|h| h[:updated_at]}.max
    time_difference = TimeDifference.between(updated_at, Time.now).in_general

    { 
      confirmed: resp.sum { |r| r[:confirmed].to_i },
      deaths: resp.sum { |r| r[:deaths].to_i },
      recovered: resp.sum { |r| r[:recovered].to_i },
      updated_at: updated_at,
      last_updated: "ปรับปรุงล่าสุดเมื่อ #{time_difference[:hours]} ชั่วโมง #{time_difference[:minutes]} นาที #{time_difference[:seconds]} วินาที",
    }
  end

  def self.country(nation = 'TH')
    resp = daily_reports_by_date

    resp.detect{ |r| r[:country_id] == nation.upcase }
  end

  def self.retroact(days = 6)
    data = {}

    ((Date.yesterday - days..Date.yesterday)).each do |date|
      data[date.strftime('%d-%m-%Y')] = daily_reports_by_date(date)
    end

    data
  end

  def self.total_retroact(days = 6)
    resp = retroact(days)
    confirmed = 0
    deaths = 0
    recovered = 0

    ((Date.yesterday - days..Date.yesterday)).each do |date|
      confirmed = resp[date.strftime('%d-%m-%Y')].sum { |r| r[:confirmed].to_i }
      deaths = resp[date.strftime('%d-%m-%Y')].sum { |r| r[:deaths].to_i }
      recovered =resp[date.strftime('%d-%m-%Y')].sum { |r| r[:recovered].to_i }
    end

    { 
      confirmed: confirmed,
      deaths: deaths,
      recovered: recovered,
    }
  end
end