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
    rest_api("/current")
  end

  def self.confirmed
    rest_api("/timeseries/confirmed")
  end
end