class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    user = find_or_create_by(uid: auth[:uid]) 
    user.update_attributes(
      uid:                auth.uid,
      first_name:         auth.info.first_name,
      last_name:          auth.info.last_name,
      email:              auth.info.email,
      image:              auth.info.image,
      google_profile_url: auth.extra.raw_info.profile,
      gender:             auth.extra.raw_info.gender
    )
    user
  end

end
