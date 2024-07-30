require_relative '../../../spec_helper'

feature 'Login Negative Cases Test Suite', :qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_login.load country:"#{ENV['COUNTRY'].downcase}", language:"#{ENV['LANG'].downcase}"
    @auth = DesktopLogin.new
  end

  scenario 'Verify user can not login with invalid email' do
    @app.desktop_login.fill_login_form("#{@auth.invalid_email}", "#{@auth.valid_password}")
    @app.desktop_login.verify_taken_action_right("invalid email")
  end

  scenario 'Verify user can not login with invalid password' do
    @app.desktop_login.fill_login_form("#{@auth.valid_email}", "#{@auth.invalid_password}")
    @app.desktop_login.verify_taken_action_right("invalid password")
  end

  scenario 'Verify user can not login with empty email' do
    @app.desktop_login.fill_login_form("", "#{@auth.valid_password}")
    @app.desktop_login.verify_taken_action_right("empty email")
  end

  scenario 'Verify user can not login with empty password' do
    @app.desktop_login.fill_login_form("#{@auth.valid_email}", "")
    @app.desktop_login.verify_taken_action_right("empty password")
  end

  scenario 'Verify user can not login with empty email and empty password' do
    @app.desktop_login.fill_login_form("", "")
    @app.desktop_login.verify_taken_action_right("empty email")
  end

  scenario 'Verify user can not login with none registered email' do
    @app.desktop_login.fill_login_form("#{@auth.none_registered_email}", "#{@auth.valid_password}")
    @app.desktop_login.verify_taken_action_right("none registered email")
  end
end