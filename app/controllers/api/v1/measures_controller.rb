class Api::V1::MeasuresController < ApplicationController
  def index
    measures = current_user.measures.include_measurements

    render json: measures, status: :ok
  end
end
