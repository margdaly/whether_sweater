require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  describe 'happy path: POST /api/v0/users' do
    scenario 'creates a new user' do
      user_params =
        {
        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'password'
        }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      results = JSON.parse(response.body, symbolize_names: true)
      created_user = User.last

      expect(results[:data][:type]).to eq('users')
      expect(results[:data][:id]).to eq(created_user.id.to_s)
      expect(results[:data][:attributes]).to be_a Hash
      expect(results[:data][:attributes][:email]).to eq(created_user.email)
      expect(results[:data][:attributes][:api_key]).to eq(created_user.api_key)
      expect(created_user.api_key.length).to eq(20)
    end
  end 

  describe 'sad path: POST /api/v0/users' do
    scenario 'email already exists' do
      create(:user, email: 'whatever@example.com')

      user_params =
        {
        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'password'
        }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      failure = JSON.parse(response.body, symbolize_names: true)

      expect(failure[:error]).to eq('Validation failed: Email has already been taken')
    end

    scenario 'password confirmation does not match' do
      user_params =
        {
        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'test'
        }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      failure = JSON.parse(response.body, symbolize_names: true)

      expect(failure[:error]).to eq("Validation failed: Password confirmation doesn't match Password")
    end
  end
end
