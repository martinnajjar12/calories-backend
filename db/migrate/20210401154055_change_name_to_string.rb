class ChangeNameToString < ActiveRecord::Migration[6.1]
  def change
    change_column :measures, :name, :string
  end
end
