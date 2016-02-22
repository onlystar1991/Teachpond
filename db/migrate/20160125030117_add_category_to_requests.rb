class AddCategoryToRequests < ActiveRecord::Migration
  def change
    add_reference :requests, :category, index: true, foreign_key: true
  end
end
