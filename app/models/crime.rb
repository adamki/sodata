class Crime < ActiveRecord::Base
  validates :latitude, :longitude, presence: :true
end
