ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'capybara/rails'
require 'pry'
require 'mocha/mini_test'
require 'simplecov'
require 'vcr'
require 'webmock'

SimpleCov.start "rails"

class ActiveSupport::TestCase
  def stub_ominiauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      uid: "123",
      credentials: {
        token: ENV["test_token"]
      },
      info: {
        first_name: "john",
        last_name: "doe",
        image: "image.url",
      },
      extra: {
        raw_info:{
          picture: "pic.jpg",
          profile: "user.profile.com",
          gender: "male",
        } 
      },
    })
  end

  def create_bike
    Bike.create!(make: "Cannondale",
                 model: "SuperSix",
                 description: "The One",
                 serial_number: "12345",
                 terrain: "Road") 
  end

  def create_user
    User.create!(first_name: "John",
                last_name: "Doe",
                email: "johndoe@test.com",
                google_profile_url: "john@gmail.com")
  end

  VCR.configure do |config|
    config.cassette_library_dir = "test/cassettes"
    config.hook_into :webmock # or :fakeweb
    config.default_cassette_options = {
      record: :once,
    }
  end
end

class ActionController::TestCase
  def json_response
    JSON.parse(response.body)
  end
end
