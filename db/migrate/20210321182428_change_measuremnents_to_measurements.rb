class ChangeMeasuremnentsToMeasurements < ActiveRecord::Migration[6.1]
  def change
    rename_table :measuremnents, :measurements
  end
end
