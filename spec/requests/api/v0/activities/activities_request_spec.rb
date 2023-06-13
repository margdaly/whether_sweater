require 'rails_helper'

RSpec.describe 'Activities API', type: :request do
  describe 'happy path: GET /api/v0/activities?destination=chicago,il' do
    scenario 'happy path', :vcr do
      location = 'chicago,il'

      get "/api/v0/activities?destination=#{location}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      outcome = JSON.parse(response.body, symbolize_names: true)

      expect(outcome).to be_a Hash
      expect(outcome).to have_key :data

      data = outcome[:data]

      expect(data).to be_a Hash
      expect(data).to have_key :id
      expect(data[:id]).to eq(nil)
      expect(data).to have_key :type
      expect(data[:type]).to eq('activities')
      expect(data).to have_key :attributes
      expect(data[:attributes]).to be_a Hash

      attributes = data[:attributes]

      expect(attributes).to have_key :destination
      expect(attributes[:destination]).to eq('chicago,il')
      expect(attributes).to have_key :forecast
      expect(attributes[:forecast]).to be_a Hash
      expect(attributes[:forecast]).to have_key :summary
      expect(attributes[:forecast][:summary]).to be_a String
      expect(attributes[:forecast]).to have_key :temperature
      expect(attributes[:forecast][:temperature]).to be_a String
      expect(attributes).to have_key :activities
      expect(attributes[:activities]).to be_a Hash

    end
  end
end
