require 'rails_helper'

describe Api::V1::Users::SessionsController, type: :request do

  let (:user) { create_user }
  let (:login_url) { '/api/v1/users/login' }
  let (:logout_url) { '/api/v1/users/logout' }

  context 'When logging in' do
    before do
      post '/api/v1/users/login', params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'When password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end

  end

  context 'When logging out' do
    it 'returns 200' do
      delete logout_url

      expect(response).to have_http_status(200)
    end
  end
end
