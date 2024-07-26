# frozen_string_literal: true

shared_context 'has authentication' do
  let (:default_user) { create_user }
  let(:api_token) { '' }
  let(:default_headers) {{
    'ACCEPT' => 'application/json',
    'Authorization' => ''
  }}

  before do
    post '/api/v1/users/login', params: {
      user: {
        email: default_user.email,
        password: default_user.password
      }
    }

    api_token = response.headers['Authorization']
    default_headers['Authorization'] = api_token
  end
end
