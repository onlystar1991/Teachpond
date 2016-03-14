class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :description
      t.text :experience
      t.integer :years_experience
      t.integer :price

      t.timestamps null: false
    end
  end
end
