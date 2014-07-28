class ChangeNatArmorToSheets < ActiveRecord::Migration
  def change
  	remove_column :sheets, :nat_armor, :integer
  end
end
