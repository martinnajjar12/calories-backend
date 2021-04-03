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

  def show_calories
    calory_object = current_user.measures.find_by(name: 'calories')
    calories = current_user.measurements.where('measure_id = ?', calory_object.id).order('created_at DESC').limit(7)

    render json: calories
  end

  private
  def measurement_params
    params.permit(:value)
  end
end
