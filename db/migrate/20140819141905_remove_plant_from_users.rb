class RemovePlantFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :plant, :string
  end
end
