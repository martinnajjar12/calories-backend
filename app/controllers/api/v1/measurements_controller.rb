class Api::V1::MeasurementsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_measure = current_user.measures.find_by(name: params[:measure])
    measurement = current_measure.measurements.build(measurement_params)
    measurement.user_id = current_user.id
    if measurement.save
      render json: measurement
    else
      render json: { error: measurement.errors.messages }, status: 422
    end
  end

  private
  def measurement_params
    params.permit(:value)
  end
end
