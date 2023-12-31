require 'rails_helper'

RSpec.describe MapService do
  describe '#get_lat_lon' do
    it 'returns lat and lon for a city', :vcr do
      map_service = MapService.new

      expect(map_service.get_lat_lon('denver,co')).to be_a Hash
      expect(map_service.get_lat_lon('denver,co')).to have_key :results

      results = map_service.get_lat_lon('denver,co')[:results]
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
end
