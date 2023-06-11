class CityService
  def get_lat_lon(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  private

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
#https://www.mapquestapi.com/geocoding/v1/address?location=boulder, co&key=