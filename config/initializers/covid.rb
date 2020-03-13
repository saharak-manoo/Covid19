class Covid
  def self.rest_api(path)
    response = RestClient::Request.new({
      method: :get,
      url: "#{Figaro.env.covid_api_host}#{path}"
    }).execute do |response, request, result|
      return JSON.parse(response.to_str)
    end
  end

  def self.current
    rest_api("/current_list")
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

  def self.deaths
    rest_api("/deaths")
  end

  def self.recovered
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