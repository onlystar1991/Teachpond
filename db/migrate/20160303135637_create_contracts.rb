class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :title
      t.integer :status
      t.float :payment
      t.float :rate
      t.references :profile, index: true, foreign_key: true
      t.integer :teacher_id

      t.timestamps null: false
    end
  end
end
