class CrimeSerializer < ActiveModel::Serializer
  attributes :id, 
             :date_reported,
             :latitude,
             :longitude,
             :hundred_block_location,
             :offense_description,
             :offense_type,
             :zone_beat

  
end
