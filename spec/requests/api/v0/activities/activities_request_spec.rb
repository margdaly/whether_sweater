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

      # ActivitiesSerializer will return this hash
      data = outcome[:data]

      expect(data).to be_a Hash
      expect(data).to have_key :id
      expect(data[:id]).to eq(nil)
      expect(data).to have_key :type
      # Comes from the type of serializer
      expect(data[:type]).to eq('activities')
      expect(data).to have_key :attributes
      expect(data[:attributes]).to be_a Hash
      # an Activities Poro will have these attributes
      attributes = data[:attributes]
      # destination is the location passed in (params[:location])
      expect(attributes).to have_key :destination
      expect(attributes[:destination]).to eq('chicago,il')
      # forecast is the current weather conditions
      # comes from the ForecastService, create ForecastObject to parse data
      # current_weather[:conditions] and current_weather[:temperature]
      expect(attributes).to have_key :forecast
      expect(attributes[:forecast]).to be_a Hash
      expect(attributes[:forecast]).to have_key :summary
      expect(attributes[:forecast][:summary]).to be_a String
      expect(attributes[:forecast]).to have_key :temperature
      expect(attributes[:forecast][:temperature]).to be_a String
      # activities is a hash of two activities ie: Activity.new and Activity.new
      expect(attributes).to have_key :activities
      expect(attributes[:activities]).to be_a Hash
      #an Activity Poro will have these attributes
      
    end
  end
end
