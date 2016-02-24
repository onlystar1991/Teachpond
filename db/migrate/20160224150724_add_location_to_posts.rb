class AddLocationToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :city, :string
  end
end
