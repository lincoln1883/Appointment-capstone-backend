require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :request do
  describe 'POST /login' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password') }

    it 'logs in a user and returns a 200 status code' do
      post '/login', params: { user: { email: user.email, password: 'password' } }

      expect(response).to have_http_status(200)

      json_response = JSON.parse(response.body)
      expect(json_response['status']['code']).to eq(200)
      expect(json_response['status']['message']).to eq('Logged in successfully.')
      expect(json_response['data']['email']).to eq('test@example.com')
    end

    it 'returns a 401 status code and error message for invalid credentials' do
      post '/login', params: { user: { email: 'invalid@example', password: 'password' } }

      expect(response).to have_http_status(401)
      expect(response.body).to match(/Invalid Email or password./)
    end
  end

  describe 'DELETE /logout' do
    let(:user) { create(:user, email: 'user@example.com', password: 'password') }

    it 'logs out a user and returns a 200 status code' do
      post '/login', params: { user: { email: user.email, password: 'password' } }
      token = response.headers['Authorization']
      delete '/logout', headers: { 'Authorization' => token }

      expect(response).to have_http_status(200)
      expect(response.body).to match('status":200,"message":"logged out successfully')
    end

    it 'returns a 401 status code and error message for non-logged-in users' do
      delete '/logout'

      expect(response).to have_http_status(401)
      expect(response.body).to match(/Couldn't find an active session./)
    end
  end
end
