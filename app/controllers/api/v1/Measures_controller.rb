class Api::V1::MeasuresController < ApplicationController
  def index
    measures = current_user.measures.includes(:measurements).where('measurements.created_at >= DATE(?)',
                                                                   Time.now).references(:measurements)

    render json: measures
  end

  def create
    measure = current_user.measures.build(name: params[:name])

    if measure.save
      render json: measure
    else
      render json: { error: "You're not authorized!!" }
    end
  end
end
