class NatArmorDefaultAddedToSheets < ActiveRecord::Migration
  def change
  	add_column :sheets, :nat_armor, :integer, default: 0
  end
end
