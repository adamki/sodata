class User < ActiveRecord::Base
  has_many :bikes

  def self.from_omniauth(auth)
    user = find_or_create_by(uid: auth[:uid]) 
    user.update_attributes(
      uid:                auth.uid,
      first_name:         auth.info.first_name,
      last_name:          auth.info.last_name,
      image:              auth.info.image,
      raw_image:          auth.extra.raw_info.picture,
      google_profile_url: auth.extra.raw_info.profile,
      gender:             auth.extra.raw_info.gender
    )
    user
  end

  def self.update(user_params)
    user = User.find(user_params[:id])
    user.update_attributes!(
      first_name:    user_params[:first_name],
      last_name:     user_params[:last_name],
      email:         user_params[:email],
      phone_number:  user_params[:phone_number],
      gender:        user_params[:gender],
      gets_alert:    user_params[:gets_alert]
    )
    user.save
  end

end
