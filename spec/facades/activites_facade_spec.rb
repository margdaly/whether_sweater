require 'rails_helper'

RSpec.describe ActivitiesFacade do
  it 'exists' do
    facade = ActivitiesFacade.new('denver,co')

    expect(facade).to be_a ActivitiesFacade
  end

  describe '#forecast' do
    it 'returns the conditions and temperature for current weather', :vcr do
      facade = ActivitiesFacade.new('denver,co').forecast

      expect(facade).to be_a Hash
      expect(facade).to have_key :summary
      expect(facade[:summary]).to be_a String
      expect(facade).to have_key :temperature
      expect(facade[:temperature]).to be_a String
    end
  end

  describe '#activities' do
    it 'can determine an activity', :vcr do
      facade = ActivitiesFacade.new('denver,co')

      expect(facade.determine_activity).to be_a Hash
    end

    it 'can get activities', :vcr do
      activities = ActivitiesFacade.new('denver,co').determine_activity
      expect(activities).to be_a Hash
    end
  end
end
