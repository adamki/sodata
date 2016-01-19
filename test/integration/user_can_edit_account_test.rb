require 'test_helper'

class UserCanEditAccountTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Sodata::Application
    stub_ominiauth
  end

  test "can update acct" do
    VCR.use_cassette("dashboard#update_user") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"

      assert_equal dashboard_path, current_path
      assert page.has_content?("john doe's Profile")
      
      click_on "Update Account"
      assert_equal dashboard_path, current_path
    end
  end

  test "can add a phone number" do
    VCR.use_cassette("dashboard#update_user_phone") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"

      assert_equal dashboard_path, current_path
      assert page.has_content?("john doe's Profile")
      
      fill_in "phone_number", with: "+1234567890"
      click_on "Update Account"
      assert page.has_content?("+123456789")
      assert_equal dashboard_path, current_path
    end
  end


  test "can add and change an email" do
    VCR.use_cassette("dashboard#update_user_email_and_alerts") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"

      assert_equal dashboard_path, current_path
      assert page.has_content?("john doe's Profile")
      
      fill_in "email", with: "new_email@john.com"
      click_on "Update Account"

      assert page.has_content?("new_email@john.com")
      assert page.has_content?("False")

      check 'accept'
      click_on "Update Account"
      
      assert_equal dashboard_path, current_path
      #assert page.has_content?("True")
      assert_equal 200, page.status_code
    end
  end

  test "can delete their account" do
    VCR.use_cassette("dashboard#destroy") do
      user = User.create(first_name: "john", 
                         last_name: "doe", 
                         google_profile_url: "rew")
      visit "/"
      assert_equal root_path, current_path

      click_link "Login"
      assert_equal dashboard_path, current_path

      click_on "Delete Account"

      assert_difference 'User.count', -1 do
        delete user_path(user)
      end
      assert_equal root_path, current_path
    end
  end
end

