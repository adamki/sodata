class Crime < ActiveRecord::Base
  validates :latitude, :longitude, presence: :true
  validates :date_reported, uniqueness: :true
end
