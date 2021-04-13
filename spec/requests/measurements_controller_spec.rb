require 'rails_helper'

RSpec.describe Api::V1::MeasurementsController, type: :request do
  before(:each) do
    @current_user = create(:user)
    login
    @auth_params = get_auth_params_from_login_response_headers(response)
  end

  describe 'POST /api/v1/measurements/create' do
    context 'successful request' do
      it 'returns 201 when the measures is created' do
        post '/api/v1/measurements/create', params: { value: 25, measure: 'carbohydrates' }, headers: @auth_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'unsuccessful request' do
      it "returns 422 when the user doesn't submit a value" do
        post '/api/v1/measurements/create', params: { measure: 'carbohydrates' }, headers: @auth_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /api/v1/calories' do
    it "should return an empty array when the user hasn't submitted anything today" do
      get '/api/v1/calories', params: {}, headers: @auth_params

      expect(JSON.parse(response.body)).to eq([])
    end

    it 'should return an array with only one item if they are created in the same day' do
      post '/api/v1/measurements/create', params: { value: 25, measure: 'calories' }, headers: @auth_params
      post '/api/v1/measurements/create', params: { value: 10, measure: 'calories' }, headers: @auth_params
      post '/api/v1/measurements/create', params: { value: 35, measure: 'calories' }, headers: @auth_params

      get '/api/v1/calories', params: {}, headers: @auth_params

      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'should group by day and return the result' do
      create(:measurement, user: @current_user, measure: @current_user.measures.find_by(name: 'calories'))
      create(:measurement, user: @current_user, measure: @current_user.measures.find_by(name: 'calories'),
                           created_at: '2021-04-1 22:05:34.646813000 +0000',
                           updated_at: '2021-04-1 22:05:34.646813000 +0000')

      get '/api/v1/calories', params: {}, headers: @auth_params
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end
