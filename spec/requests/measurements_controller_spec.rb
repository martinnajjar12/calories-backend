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

  describe 'POST /api/v1/measurements/create' do
    before(:each) do
      @current_user = create(:user)
    end

    context 'successful request' do
      it 'returns 201 when the measures is created' do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        post '/api/v1/measurements/create', params: { value: 25, measure: 'carbohydrates' }, headers: auth_params
  
        expect(response).to have_http_status(:created)
      end
    end

    context 'unsuccessful request' do
      it "returns 422 when the user doesn't submit a value" do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        post '/api/v1/measurements/create', params: { measure: 'carbohydrates' }, headers: auth_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
