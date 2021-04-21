class AddUserIdToMeasures < ActiveRecord::Migration[6.1]
  def change
    add_reference :measures, :user, null: false, foreign_key: true
  end
end
