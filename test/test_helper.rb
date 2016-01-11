ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
SimpleCov.start 'rails' do
    require 'simplecov-badge'
    # add your normal SimpleCov configs
    add_filter "/app/admin/"
    # configure any options you want for SimpleCov::Formatter::BadgeFormatter
    SimpleCov::Formatter::BadgeFormatter.generate_groups = true
    SimpleCov::Formatter::BadgeFormatter.strength_foreground = true
    SimpleCov::Formatter::BadgeFormatter.timestamp = true
    # call SimpleCov::Formatter::BadgeFormatter after the normal HTMLFormatter
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
        SimpleCov::Formatter::HTMLFormatter,
        SimpleCov::Formatter::BadgeFormatter,
    ]
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
