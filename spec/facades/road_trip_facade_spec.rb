require 'rails_helper'

RSpec.describe RoadTripFacade do
  before :each do
    @origin = 'Cincinatti,OH'
    @destination = 'Chicago,IL'
    @roadtrip_facade = RoadTripFacade.new(@origin, @destination)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@roadtrip_facade).to be_a RoadTripFacade
    end
  end

  describe '#travel_time' do
    it 'returns travel time', :vcr do
      expect(@roadtrip_facade.travel_time).to be_a String
      expect(@roadtrip_facade.travel_time).to eq('04:20:37')
    end
  end

  describe '#arrival_time' do
    it 'returns arrival time', :vcr do
      expect(@roadtrip_facade.travel_time).to be_a String
    end
  end
end
