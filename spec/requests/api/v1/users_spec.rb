require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'GET /api/v1/users/index' do
    context 'when the user is authenticated' do
      let(:user) { create(:user) }

      before do
        sign_in user
        get '/api/v1/users'
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'returns user attributes in JSON' do
        json_response = JSON.parse(response.body)
        expect(json_response).to include('name', 'email', 'role', 'created_at', 'id')
      end
    end

    context 'when the user is not authenticated' do
      before do
        get '/api/v1/users'
      end

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(401)
      end

      it 'returns an error message in JSON' do
        expect(response.body).to include('You need to sign in or sign up before continuing.')
      end
    end
  end
end
