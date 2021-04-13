class Api::V1::MeasuresController < ApplicationController
  def index
    measures = current_user.measures.includes(:measurements).where('measurements.created_at >= DATE(?)',
                                                                   Time.now).references(:measurements)

    render json: measures, status: :ok
  end
end
