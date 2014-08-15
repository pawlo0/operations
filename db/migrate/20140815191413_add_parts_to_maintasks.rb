class AddPartsToMaintasks < ActiveRecord::Migration
  def change
    add_column :maintasks, :parts, :string
  end
end
