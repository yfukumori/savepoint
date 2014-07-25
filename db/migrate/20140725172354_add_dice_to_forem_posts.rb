class AddDiceToForemPosts < ActiveRecord::Migration
  def change
  	add_column :forem_posts, :no_of_die, :integer
  	add_column :forem_posts, :no_of_side, :integer
  	add_column :forem_posts, :roll_mod, :string
  end
end