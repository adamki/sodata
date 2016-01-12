class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :image
      t.string :google_profile_url
      t.string :gender
      t.string :uid
      t.string :email

      t.timestamps null: false
    end
  end
end
