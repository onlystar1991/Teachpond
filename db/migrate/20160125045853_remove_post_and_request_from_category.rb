class RemovePostAndRequestFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :post_id
    remove_column :categories, :request_id
  end
end
