class ForecastFacade
  def get_forecast(location)
    lat_lon = map_service.get_lat_lon(location)
    lat = lat_lon[:results].first[:locations].first[:latLng][:lat]
    lon = lat_lon[:results].first[:locations].first[:latLng][:lng]

    weather = weather_service.get_weather(lat, lon)

    current_weather = get_current(weather)
    daily_weather = get_daily(weather)
    hourly_weather = get_hourly(weather)

    Forecast.new(current_weather, daily_weather, hourly_weather)
  end
  
  private

  def get_current(weather)
    {
      last_updated: weather[:current][:last_updated],
      temperature: weather[:current][:temp_f],
      feels_like: weather[:current][:feelslike_f],
      humidity: weather[:current][:humidity],
      uvi: weather[:current][:uv],
      visibility: weather[:current][:vis_miles],
      condition: weather[:current][:condition][:text],
      icon: weather[:current][:condition][:icon]
    }
  end

  def get_daily(weather)
    weather[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def get_hourly(weather)
    weather[:forecast][:forecastday].first[:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end

  def map_service
    @map_service ||= MapService.new
  end

  def weather_service
    @weather_service ||= WeatherService.new
  end
end
