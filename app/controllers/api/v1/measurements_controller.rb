class Api::V1::MeasurementsController < ApplicationController
  def create
    @measurement = Measurement.new(measurement_params)
  end

  private
  def measurement_params
    params.require(:measurement).permit(:value)
  end
end
