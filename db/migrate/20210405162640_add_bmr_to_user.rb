class AddBmrToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bmr, :integer
  end
end
