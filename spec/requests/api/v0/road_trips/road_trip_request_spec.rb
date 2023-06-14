require 'rails_helper'

RSpec.describe 'Road Trip API' do
  describe 'happy path: POST /api/v0/road_trip' do
    scenario 'returns road trip information', :vcr do
      roadtrip_params = {
        'origin': 'Cincinatti,OH',
        'destination': 'Chicago,IL',
        'api_key': 't1h2i3s4_i5s6_l7e8g9i10t11'
      }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      roadtrip = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(roadtrip).to be_a Hash
      expect(roadtrip).to have_key(:id)
      expect(roadtrip[:id]).to eq(nil)
      expect(roadtrip).to have_key(:type)
      expect(roadtrip[:type]).to eq('roadtrip')
      expect(roadtrip).to have_key(:attributes)
      expect(roadtrip[:attributes]).to be_a Hash

      attributes = roadtrip[:attributes]

      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to eq(roadtrip_params[:origin])
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to eq(roadtrip_params[:destination])
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a String
      expect(attributes).to have_key(:weather_at_eta)
      expect(attributes[:weather_at_eta]).to be_a Hash

      eta_weather = attributes[:weather_at_eta]

      expect(eta_weather).to have_key(:datetime)
      expect(eta_weather[:datetime]).to be_a String
      expect(eta_weather).to have_key(:temperature)
      expect(eta_weather[:temperature]).to be_a Float
      expect(eta_weather).to have_key(:condition)
      expect(eta_weather[:condition]).to be_a String
    end
  end

  describe 'sad path: POST /api/v0/road_trip' do
    # If no API key is given, or an incorrect key is provided, return 401 (Unauthorized
    scenario 'no api key is given', :vcr do
      roadtrip_params = {
        'origin': 'cincinatti,oh',
        'destination': 'chicago,il',
      }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
    end

    scenario 'incorrect api key is given', :vcr do
      roadtrip_params = {
        'origin': 'cincinatti,oh',
        'destination': 'chicago,il',
        'api_key': 't1h21'
      }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
    end
  end
end
