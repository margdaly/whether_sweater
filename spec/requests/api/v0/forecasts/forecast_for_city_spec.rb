require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'sends a forecast for a city' do
    scenario 'happy path', :vcr do
      location = 'denver,co'

      get "/api/v0/forecast?location=#{location}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a Hash
      expect(forecast).to have_key :data

      data = forecast[:data]

      expect(data).to be_a Hash
      expect(data).to have_key :id
      expect(data[:id]).to eq(nil)
      expect(data).to have_key :type
      expect(data[:type]).to eq('forecast')
      expect(data).to have_key :attributes
      expect(data[:attributes]).to be_a Hash

      attributes = data[:attributes]

      expect(attributes).to have_key :current_weather
      expect(attributes[:current_weather]).to be_a Hash

      current = attributes[:current_weather]
      expect(current).to have_key :last_updated
      expect(current[:last_updated]).to be_a String
      expect(current).to have_key :temperature
      expect(current[:temperature]).to be_a Float
      expect(current).to have_key :feels_like
      expect(current[:feels_like]).to be_a Float
      expect(current).to have_key :humidity
      expect(current[:humidity]).to be_a Integer
      expect(current).to have_key :uvi
      expect(current[:uvi]).to be_a Float
      expect(current).to have_key :visibility
      expect(current[:visibility]).to be_a Float
      expect(current).to have_key :condition
      expect(current[:condition]).to be_a String
      expect(current).to have_key :icon
      expect(current[:icon]).to be_a String

      expect(attributes).to have_key :daily_weather
      expect(attributes[:daily_weather]).to be_an Array

      daily = attributes[:daily_weather]

      expect(daily.count).to eq(5)
      daily.each do |day|
        expect(day).to be_a Hash
        expect(day).to have_key :date
        expect(day[:date]).to be_a String
        expect(day).to have_key :sunrise
        expect(day[:sunrise]).to be_a String
        expect(day).to have_key :sunset
        expect(day[:sunset]).to be_a String
        expect(day).to have_key :max_temp
        expect(day[:max_temp]).to be_a Float
        expect(day).to have_key :min_temp
        expect(day[:min_temp]).to be_a Float
        expect(day).to have_key :condition
        expect(day[:condition]).to be_a String
        expect(day).to have_key :icon
        expect(day[:icon]).to be_a String
      end

      expect(attributes).to have_key :hourly_weather
      expect(attributes[:hourly_weather]).to be_an Array

      hourly = attributes[:hourly_weather]

      expect(hourly).to be_an Array
      expect(hourly.count).to eq(24)
      hourly.each do |hour|
        expect(hour).to be_a Hash
        expect(hour).to have_key :time
        expect(hour[:time]).to be_a String
        expect(hour).to have_key :temperature
        expect(hour[:temperature]).to be_a Float
        expect(hour).to have_key :condition
        expect(hour[:condition]).to be_a String
        expect(hour).to have_key :icon
        expect(hour[:icon]).to be_a String
      end
    end
  end
end
