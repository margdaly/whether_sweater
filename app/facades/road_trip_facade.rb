class RoadTripFacade

  def initialize(origin, destination)
    @start_city = origin
    @end_city = destination
  end

  def road_trip
    if trip[:info][:statuscode] == 402
      RoadTrip.new(origin, destination, 'impossible route', {})
    else
      weather[:forecast][:forecastday].map do |day|
        if day[:date] == date
          day[:hour].map do |hour|
            if hour[:time] == date + ' ' + time.strftime('%H:%M')
              weather_at_eta = weather_service.get_trip_weather(date, time, lat, lon)
              RoadTrip.new(@start_city, @end_city, travel_time, weather_at_eta)
            end
          end
        end
      end
    end
  end

  def travel_time
    trip[:route][:formattedTime]
  end

  def date
    time.strftime('%Y-%m-%d')
  end

  def time
    Time.now + trip[:route][:realTime]
  end

  private

  def weather
    lat_lon = mapquest_service.get_lat_lon(@end_city)
    lat = lat_lon[:results].first[:locations].first[:latLng][:lat]
    lon = lat_lon[:results].first[:locations].first[:latLng][:lng]
    weather_service.get_weather(lat, lon)
  end

  def trip
    mapquest_service.get_timing(@start_city, @end_city)
  end

  def mapquest_service
    @mapquest_service ||= MapService.new
  end

  def weather_service
    @weather_service ||= WeatherService.new
  end
end
