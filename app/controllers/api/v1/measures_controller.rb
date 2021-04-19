class Api::V1::MeasuresController < ApplicationController
  def index
    measures = current_user.measures.include_measurements

    render json: measures, status: :ok
  end

  def show
    calory_object = current_user.measures.find_by(name: 'calories')
    calories = current_user.measurements.calories_grouped_by_date(calory_object)

    results = []
    calories&.first(5)&.each do |key, value|
      hash = { created_at: key, value: value }
      results << hash
    end

    render json: results, status: 200
  end
end
