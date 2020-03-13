class Covid
  def self.rest_api(path)
    response = RestClient::Request.new({
      method: :get,
      url: "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
    }).execute do |response, request, result|
      return JSON.parse(CSV.parse(response.to_str).to_json)
    end
  end

  def self.current
    data = rest_api("/current_list")
    ap data
    ap '>>>'

    data
  end

  def self.confirmed
    rest_api("/timeseries/confirmed")
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