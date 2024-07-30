require_relative '../../../spec_helper'

feature 'New Account Registration and Login Test Suite',:uae, :qat do

  scenario 'Verify user can register successfully' do
    set_host ("cover")
    @app.desktop_register.load country:"#{ENV['COUNTRY'].downcase}", language:"#{ENV['LANG'].downcase}"
    auth = DesktopRegister.new
    @app.desktop_register.create_new_account( "#{auth.name}", "#{auth.email}", "#{auth.phone}", "#{auth.password}")
    @app.desktop_register.verify_taken_action_right("success_msg", "You will receive a confirmation email from us.")
  end

  scenario 'Verify user can login succesfully' do
    set_host ("cover")
    @app.desktop_login.load country:"#{ENV['COUNTRY'].downcase}", language:"#{ENV['LANG'].downcase}"
    auth = DesktopLogin.new
    @app.desktop_login.fill_login_form("#{auth.valid_email}", "#{auth.valid_password}")
    @app.desktop_my_account_detail.verify_taken_action_right("success login")
  end
end
