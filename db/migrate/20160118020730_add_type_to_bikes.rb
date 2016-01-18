class AddTypeToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :terrain, :string
  end
end
