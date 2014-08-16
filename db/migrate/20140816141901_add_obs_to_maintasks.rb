class AddObsToMaintasks < ActiveRecord::Migration
  def change
    add_column :maintasks, :obs, :string
  end
end
