require 'rails_helper'

RSpec.describe MapService do
  before { @map_service = MapService.new }

  describe '#get_lat_lon' do
    it 'returns lat and lon for a city', :vcr do
      expect(@map_service.get_lat_lon('denver,co')).to be_a Hash
      expect(@map_service.get_lat_lon('denver,co')).to have_key :results

      results = @map_service.get_lat_lon('denver,co')[:results]
      expect(results).to be_an Array
      expect(results.first).to be_a Hash
      expect(results.first).to have_key :locations

      locations = results.first[:locations]
      expect(locations).to be_an Array
      expect(locations.first).to be_a Hash
      expect(locations.first).to have_key :latLng

      lat_lng = locations.first[:latLng]
      expect(lat_lng).to be_a Hash
      expect(lat_lng).to have_key :lat
      expect(lat_lng).to have_key :lng
    end
  end

  describe '#get_timing' do
    it 'returns timing for a trip', :vcr do
      origin = 'New York, NY'
      destination = 'Los Angeles, CA'
      directions = @map_service.get_timing(origin, destination)

      expect(directions).to be_a Hash
      expect(directions).to have_key :route
      expect(directions[:route]).to be_a Hash
      expect(directions[:route]).to have_key :formattedTime
      expect(directions[:route][:formattedTime]).to be_a String
      expect(directions[:route]).to have_key :realTime
      expect(directions[:route][:realTime]).to be_an Integer
    end
  end
end
