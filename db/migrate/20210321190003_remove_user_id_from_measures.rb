class RemoveUserIdFromMeasures < ActiveRecord::Migration[6.1]
  def change
    remove_column :measures, :user_id
  end
end
