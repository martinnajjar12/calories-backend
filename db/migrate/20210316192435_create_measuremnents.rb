class CreateMeasuremnents < ActiveRecord::Migration[6.1]
  def change
    create_table :measuremnents do |t|
      t.integer :value
      t.references :measure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
