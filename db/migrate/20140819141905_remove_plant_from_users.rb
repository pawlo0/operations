class RemovePlantFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :plant, :string
  end
  
  def self.down
    add_column :users, :plant, :string
  end
end
