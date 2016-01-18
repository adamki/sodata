class AddRawImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :raw_image, :string
  end
end
