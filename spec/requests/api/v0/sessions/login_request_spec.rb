require 'rails_helper'

RSpec.decribe 'Login Request' do
  describe 'happy path: POST /api/v0/sessions' do
    scenario 'user logs in', :vcr do
      login_params = 
      {
        "email": "whatever@example.com",
        "password": "password"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      login = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(login).to be_a Hash
      expect(login).to have_key(:type)
      expect(login[:type]).to eq('users')
      expect(login).to have_key(:id)
      expect(login[:id]).to be_a String
      expect(login).to have_key(:attributes)
      expect(login[:attributes]).to be_a Hash

      attributes = login[:attributes]

      expect(attributes).to have_key(:email)
      expect(attributes[:email]).to be_a String
      expect(attributes).to have_key(:api_key)
      expect(attributes[:api_key]).to be_a String
      expect(attributes[:api_key].length).to eq(20)
    end
  end
end
