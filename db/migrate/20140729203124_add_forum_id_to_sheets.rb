class AddForumIdToSheets < ActiveRecord::Migration
  def change
  	add_column :sheets, :forum_id, :integer
  end
end
