class Api::V1::MeasuresController < ApplicationController
  def index
    @measures = Measure.all

    render json: @measures
  end

  def create
    measure = current_user.measures.build(name: params[:name])

    if measure.save
      render json: measure
    else
      render json: { error: 'This is not allowed' }
    end
  end
end