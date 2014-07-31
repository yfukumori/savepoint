class AddResultToForemPost < ActiveRecord::Migration
  def change
  	  	add_column :forem_posts, :result, :integer
  end
end
