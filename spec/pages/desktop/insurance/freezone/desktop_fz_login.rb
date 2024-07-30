require_relative '../../../base_page.rb'

class DesktopFzLogin < BasePage

  set_url('https://dcc.testingyalla.xyz/uae/en/login')

  element :user_name_field,:css,"[id='login_email']"
  element :password_field,:css,"[id='login_password']"
  element :login_button,:css,"[type='submit']"

  def login(username,password)
    user_name_field.send_keys(username)
    password_field.send_keys(password)
    login_button.click
  end

end


