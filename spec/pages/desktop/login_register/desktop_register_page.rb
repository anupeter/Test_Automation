require_relative '../../base_page.rb'
# require '../../../spec_helper'

class DesktopRegister < BasePage

  set_url ('{country}/{language}/my-account/sign-up/')

  element :name_field, :css, "input[name='name']"
  element :email_field, :xpath, "(//input[@name='email'])[1]"
  element :phone_field, :css, "input[name='phone']"
  element :password_field, :css, "input[name='password']"
  element :sign_up_button, :css, ".button.form__button"
  element :success_msg, :css, "span[class='success-msg']"

  attr_accessor :name, :email, :password, :phone

  def initialize
    @name = $test_data['NAME']
    @email = "desktop_automation_" + Time.now.utc.strftime("%Y%m%d%H%M%S") + "_#{ENV['COUNTRY'].downcase}@yallacompare.ae"
    @password = $test_data['VALID_PASSWORD']
    @phone = $test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']
  end

  def create_new_account(name, email, phone, password)
    name_field.send_keys(name)
    email_field.send_keys(email)
    phone_field.send_keys(phone)
    password_field.send_keys(password)
    sign_up_button.click
  end

  def verify_taken_action_right(element, message)
    expect(eval(element).text).to include(message)
  end
end