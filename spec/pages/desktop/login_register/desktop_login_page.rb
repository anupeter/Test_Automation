require_relative '../../base_page.rb'
# require '../../../spec_helper'

class DesktopLogin < BasePage

  set_url ('{country}/{language}/my-account/log-in/')

  element :email_field, :css, "input[name='username']"
  element :password_field, :css, "input[name='password']"
  element :login_button, :css, "button[id='signUpBtn']"
  element :error_msg, :css, "span[class='error-msg']"

  attr_accessor :valid_email, :valid_password, :invalid_email, :invalid_password, :none_registered_email

  def initialize
    @valid_email = $test_data['VALID_EMAIL']
    @valid_password = $test_data['VALID_PASSWORD']
    @invalid_email = $test_data['INVALID_EMAIL']
    @invalid_password = $test_data['INVALID_PASSWORD']
    @none_registered_email = $test_data['NONE_REGISTERED_EMAIL']
  end

  def fill_login_form(email, password)
    email_field.send_keys(email)
    password_field.send_keys(password)
    login_button.click
  end

  def verify_taken_action_right(scenario)
    case scenario
    when "invalid email", "empty password"
      expect(error_msg.text).to eq("Incorrect username or password")
      expect(page).not_to have_css("i[class='banking-icon-logout']")
    when "invalid password", "none registered email"
      expect(error_msg.text).to eq("Sorry, we were not able to find a user with that username and password.")
    when "empty email"
      expect(page).not_to have_css("i[class='banking-icon-logout']")
    end
  end
end