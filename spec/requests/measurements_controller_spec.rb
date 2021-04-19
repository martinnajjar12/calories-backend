require 'rails_helper'

RSpec.describe Api::V1::MeasurementsController, type: :request do
  before(:each) do
    @current_user = create(:user)
    login
    @auth_params = get_auth_params_from_login_response_headers(response)
  end

  describe 'POST /api/v1/measurements' do
    context 'successful request' do
      it 'returns 201 when the measures is created' do
        post '/api/v1/measurements', params: { value: 25, measure: 'carbohydrates' }, headers: @auth_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'unsuccessful request' do
      it "returns 422 when the user doesn't submit a value" do
        post '/api/v1/measurements', params: { measure: 'carbohydrates' }, headers: @auth_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
