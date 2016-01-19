require 'test_helper'

class UserLogsInWithGoogleTest < ActionDispatch::IntegrationTest
  include Capybara::DSL


  def setup
    Capybara.app = Sodata::Application
    stub_ominiauth
  end

  test "logging in" do
    VCR.use_cassette("welcome#login") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"

      assert_equal dashboard_path, current_path
      assert page.has_content?("john doe's Profile")

      click_link "Logout"
      click_link "Yes, I am ready."
      assert_equal root_path, current_path
    end
  end
end

