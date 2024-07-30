require_relative '../../../../base_page.rb'

class MobileBrokerLogin < BasePage

  set_url ('login')

  element :username_field, :css, "[name='username']"
  element :password_field, :css, "[name='password']"
  element :login_button, :css, "[type='submit']"

  def login(name, password)
    username_field.send_keys(name)
    password_field.send_keys(password)
    login_button.click
  end
end