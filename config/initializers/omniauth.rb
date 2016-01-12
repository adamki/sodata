Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "571421253422-617kkctqi1m5oel5lb0j3njff01tlqpe.apps.googleusercontent.com", "0d4bav0ydRlYy8Ae9xCxGQyT",
     scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google', prompt: 'select_account'
end

