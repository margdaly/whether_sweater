class ActivitiesFacade

  def initialize(location)
    @destination = location
  end
  
  def get_activities
    Activities.new(@destination, forecast, determine_activity)
  end

  def determine_activity
    if current_weather[:temperature] >= 60
      { 
       "#{activities_service.relaxing_activity[:activity]}": Activity.new(activities_service.relaxing_activity),
       "#{activities_service.recreational_activity[:activity]}": Activity.new(activities_service.recreational_activity)
      }
    elsif current_weather[:temperature] >= 50 && current_weather[:temperature] < 60
      { 
        "#{activities_service.relaxing_activity[:activity]}": Activity.new(activities_service.relaxing_activity),
        "#{activities_service.busywork_activity[:activity]}": Activity.new(activities_service.busywork_activity)
      }
    else
      { 
        "#{activities_service.relaxing_activity[:activity]}": Activity.new(activities_service.relaxing_activity),
        "#{activities_service.cooking_activity[:activity]}": Activity.new(activities_service.cooking_activity)
      }
    end
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
    @activities_service ||= ActivityService.new
  end

  def map_service
    @map_service ||= MapService.new
  end
end
