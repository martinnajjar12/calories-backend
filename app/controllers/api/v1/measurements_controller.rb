class Api::V1::MeasurementsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_measure = current_user.measures.find_by(name: params[:measure])
    measurement = current_measure.measurements.build(measurement_params)
    measurement.user_id = current_user.id
    if measurement.save
      render json: measurement, status: 201
    else
      render json: measurement.errors, status: 422
    end
  end

  def show_calories
    calory_object = current_user.measures.find_by(name: 'calories')
    calories = current_user.measurements
      .where('measure_id = ?', calory_object.id).order('DATE(created_at) DESC').group('DATE(created_at)').sum(:value)
    results = []
    calories&.first(5).each do |key, value|
      hash = { created_at: key, value: value }
      results << hash
    end

    render json: results, status: 200
  end

  private

  def measurement_params
    params.permit(:value)
  end
end
