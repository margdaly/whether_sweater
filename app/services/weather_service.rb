class WeatherService
  def get_weather(lat, lon)
    get_url("/v1/forecast.json?&days=5&q=#{lat},#{lon}")
  end

  private

  def conn
    Faraday.new(url: 'http://api.weatherapi.com') do |f|
      f.params['key'] = ENV['WEATHER_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
