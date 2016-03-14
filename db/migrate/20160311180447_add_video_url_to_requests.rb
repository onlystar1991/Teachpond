class AddVideoUrlToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :url, :string
  end
end
