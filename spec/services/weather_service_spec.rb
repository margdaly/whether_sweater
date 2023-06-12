require 'rails_helper'

RSpec.describe WeatherService do
  describe '#get_weather' do
    it 'returns the current weather for a city', :vcr do
      lat = 39.738453
      lon = -104.984853
      current_weather = WeatherService.new.get_weather(lat, lon)

      expect(current_weather).to be_a Hash
      expect(current_weather).to have_key :current

      current = current_weather[:current]
      expect(current).to be_a Hash

      expect(current).to have_key :last_updated
      expect(current[:last_updated]).to be_a String

      expect(current).to have_key :temp_f
      expect(current[:temp_f]).to be_a Float

      expect(current).to have_key :condition
      expect(current[:condition]).to be_a Hash
      expect(current[:condition]).to have_key :text
      expect(current[:condition][:text]).to be_a String
      expect(current[:condition]).to have_key :icon
      expect(current[:condition][:icon]).to be_a String

      expect(current).to have_key :feelslike_f
      expect(current[:feelslike_f]).to be_a Float

      expect(current).to have_key :humidity
      expect(current[:humidity]).to be_a Integer

      expect(current).to have_key :vis_miles
      expect(current[:vis_miles]).to be_a Float

      expect(current).to have_key :uv
      expect(current[:uv]).to be_a Float

      expect(current).to_not have_key :temp_c
      expect(current).to_not have_key :wind_mph
      expect(current).to_not have_key :vis_km
    end

    it 'returns the 5 day forecast for a city', :vcr do
      lat = 39.738453
      lon = -104.984853
      daily_weather = WeatherService.new.get_weather(lat, lon)

      expect(daily_weather).to be_a Hash
      expect(daily_weather).to have_key :forecast
      expect(daily_weather[:forecast]).to be_a Hash
      expect(daily_weather[:forecast]).to have_key :forecastday

      forecastday = daily_weather[:forecast][:forecastday]

      expect(forecastday).to be_an Array
      expect(forecastday.count).to eq(5)

      forecastday.each do |forecast|
        expect(forecast).to be_a Hash

        expect(forecast).to have_key :date
        expect(forecast[:date]).to be_a String

        expect(forecast).to have_key :day
        expect(forecast[:day]).to be_a Hash
        expect(forecast[:day]).to have_key :maxtemp_f
        expect(forecast[:day][:maxtemp_f]).to be_a Float
        expect(forecast[:day]).to have_key :mintemp_f
        expect(forecast[:day][:mintemp_f]).to be_a Float

        expect(forecast[:day]).to have_key :condition
        expect(forecast[:day][:condition]).to be_a Hash
        expect(forecast[:day][:condition]).to have_key :text
        expect(forecast[:day][:condition][:text]).to be_a String
        expect(forecast[:day][:condition]).to have_key :icon
        expect(forecast[:day][:condition][:icon]).to be_a String

        expect(forecast).to have_key :astro
        expect(forecast[:astro]).to be_a Hash
        expect(forecast[:astro]).to have_key :sunrise
        expect(forecast[:astro][:sunrise]).to be_a String
        expect(forecast[:astro]).to have_key :sunset
        expect(forecast[:astro][:sunset]).to be_a String

        expect(forecast).to_not have_key :moonrise
        expect(forecast).to_not have_key :moonset
      end
    end

    it 'returns the hourly forecast for a city', :vcr do
      lat = 39.738453
      lon = -104.984853
      hourly_weather = WeatherService.new.get_weather(lat, lon)

      expect(hourly_weather).to be_a Hash
      expect(hourly_weather).to have_key :forecast
      expect(hourly_weather[:forecast]).to have_key :forecastday

      hourly_weather[:forecast][:forecastday].each do |forecast|
        expect(forecast).to be_a Hash
        expect(forecast).to have_key :hour
        expect(forecast[:hour]).to be_an Array
        expect(forecast[:hour].count).to eq(24)

        forecast[:hour].each do |hour|
          expect(hour).to be_a Hash
          expect(hour).to have_key :time
          expect(hour[:time]).to be_a String

          expect(hour).to have_key :temp_f
          expect(hour[:temp_f]).to be_a Float

          expect(hour).to have_key :condition
          expect(hour[:condition]).to be_a Hash
          expect(hour[:condition]).to have_key :text
          expect(hour[:condition][:text]).to be_a String
          expect(hour[:condition]).to have_key :icon
          expect(hour[:condition][:icon]).to be_a String
        end
      end
    end
  end
end
