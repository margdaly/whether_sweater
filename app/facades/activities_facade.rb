class ActivitiesFacade

  def initialize(location)
    @destination = location
  end
  
  def forecast
    {
      "summary": current_weather[:condition],
      "temperature": "#{current_weather[:temperature]} F"
    }
  end
  
  private

  def current_weather
    forecast_data.current_weather
  end

  def forecast_data
    @forecast ||= ForecastFacade.new.get_forecast(@destination)
  end

  def weather_service
    @weather_service ||= WeatherSercvice.new
  end

  def activities_service
    @activities_service ||= ActivitiesService.new
  end

  def map_service
    @map_service ||= MapService.new
  end
end
