Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["google_client_id"], ENV["google_client_secret"],
     scope: 'profile', 
     image_aspect_ratio: 'square', 
     image_size: 48, 
     access_type: 'online', 
     name: 'google', 
     prompt: 'select_account'
end

