class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :title
      t.text :description

      t.timestamps null: false
    end
  end
end
