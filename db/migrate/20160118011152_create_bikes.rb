class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :make
      t.string :model
      t.string :serial_number
      t.string :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
