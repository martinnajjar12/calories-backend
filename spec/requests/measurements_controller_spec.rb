require 'rails_helper'

RSpec.describe Api::V1::MeasurementsController, type: :request do
  describe 'GET /api/v1/measures' do
    before(:each) do
      @current_user = FactoryBot.create(:user)
      @measures = create_list(:measure, 3, user: @current_user)
      @measures.each do |measure|
        @measurements = FactoryBot.create(:measurement, user: @current_user, measure: measure)
      end
    end

    context 'response status' do
      it 'returns a status code of 200' do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        get '/api/v1/measures', params: {}, headers: auth_params

        expect(response).to have_http_status(200)
      end
    end

    context 'response body' do
      it 'returns 3 measures as we already created them' do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        get '/api/v1/measures', params: {}, headers: auth_params

        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
  end

  private

  def login
    post user_session_path, params:  { email: @current_user.email, password: 'password' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
    auth_params
  end

end
