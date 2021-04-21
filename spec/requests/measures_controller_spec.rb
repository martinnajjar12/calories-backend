require 'rails_helper'

RSpec.describe Api::V1::MeasuresController, type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:user)
    @measures = create_list(:measure, 3, user: @current_user)
    @measures.each do |measure|
      @measurements = FactoryBot.create(:measurement, user: @current_user, measure: measure)
    end
    login
    @auth_params = get_auth_params_from_login_response_headers(response)
  end

  describe 'GET /api/v1/measures' do
    context 'response status' do
      it 'returns a status code of 200' do
        get '/api/v1/measures', params: {}, headers: @auth_params

        expect(response).to have_http_status(200)
      end
    end

    context 'response body' do
      it 'returns 3 measures as we already created them' do
        get '/api/v1/measures', params: {}, headers: @auth_params

        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
  end

  describe 'GET /api/v1/measures/:id' do
    it "should return an empty array when the user hasn't submitted anything today" do
      get '/api/v1/measures/1', params: {}, headers: @auth_params

      expect(JSON.parse(response.body)).to eq([])
    end

    it 'should return an array with only one item if they are created in the same day' do
      post '/api/v1/measurements/', params: { value: 25, measure: 'calories' }, headers: @auth_params
      post '/api/v1/measurements/', params: { value: 10, measure: 'calories' }, headers: @auth_params
      post '/api/v1/measurements/', params: { value: 35, measure: 'calories' }, headers: @auth_params

      get '/api/v1/measures/1', params: {}, headers: @auth_params

      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'should group by day and return the result' do
      create(:measurement, user: @current_user, measure: @current_user.measures.find_by(name: 'calories'))
      create(:measurement, user: @current_user, measure: @current_user.measures.find_by(name: 'calories'),
                           created_at: '2021-04-1 22:05:34.646813000 +0000',
                           updated_at: '2021-04-1 22:05:34.646813000 +0000')

      get '/api/v1/measures/1', params: {}, headers: @auth_params
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end
