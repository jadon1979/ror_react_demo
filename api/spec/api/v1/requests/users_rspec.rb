require 'rails_helper'

describe 'Users' do
  context 'authentication' do
    it 'should authenticate_user' do
      user = create(:user, confirmed_at: DateTime.now)

      post '/api/v1/login', params: {
        user: { email: user.email, password: user.password }
      }

      data = JSON.parse(response.body)
      expect(data['status']['code']).to eq(200)
      expect(data['status']['message']).to eq('Logged in successfully.')
    end
  end
end
