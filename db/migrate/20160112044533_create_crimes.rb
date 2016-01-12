class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.string :latitude
      t.string :longitude
      t.string :offense_code
      t.string :offense_type
      t.string :date_reported
      t.string :zone_beat
      t.string :hundred_block_location
      t.string :offense_description

      t.timestamps null: false
    end
  end
end
