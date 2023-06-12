require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'exists' do
    forecast_facade = ForecastFacade.new

    expect(forecast_facade).to be_a ForecastFacade
  end

  describe '#get_forecast' do
    it 'returns a forecast object', :vcr do
      forecast = ForecastFacade.new.get_forecast('denver,co')

      expect(forecast).to be_a Forecast
      expect(forecast.current_weather).to be_a Hash
      expect(forecast.daily_weather).to be_an Array
      expect(forecast.daily_weather.count).to eq(5)
      expect(forecast.daily_weather.first).to be_a Hash
      expect(forecast.hourly_weather).to be_an Array
      expect(forecast.hourly_weather.count).to eq(24)
      expect(forecast.hourly_weather.first).to be_a Hash
    end
  end

  describe '#only_current' do
    it 'returns only the current weatehr', :vcr do
      forecast = ForecastFacade.new.only_current('denver,co')

      expect(forecast).to be_a Forecast
      expect(forecast.current_weather).to be_a Hash
      expect(forecast.daily_weather).to be_an Array
      expect(forecast.daily_weather).to eq([])
      expect(forecast.hourly_weather).to be_an Array
      expect(forecast.hourly_weather).to eq([])
    end
  end
end
