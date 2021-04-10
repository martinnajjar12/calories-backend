class Api::V1::MeasuresController < ApplicationController
  def index
    measures = current_user.measures.includes(:measurements).where('measurements.created_at >= DATE(?)',
                                                                   Time.now).references(:measurements)

    render json: measures, status: :ok
  end

  def create
    measure = current_user.measures.build(name: params[:name])

    if measure.save
      render json: measure, status: :created
    else
      render json: measure.errors, status: :unprocessable_entity
    end
  end
end
