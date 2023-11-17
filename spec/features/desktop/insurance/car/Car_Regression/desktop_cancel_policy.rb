require_relative '../../../../../spec_helper'

feature 'Car Insurance Cancel Policy Test Suite', :uae, :skip_egy do
  before do
    set_host ("cover")
    @app.desktop_car_landing.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @valid_email = "#{$test_data['VALID_EMAIL']}"
    @invalid_email = "#{$test_data['INVALID_EMAIL']}"
    @none_registered_email = "#{$test_data['NONE_REGISTERED_EMAIL']}"
  end

  scenario 'Verify user can cancel policy if email valid' do
    @app.desktop_car_landing.cancel_policy("#{@valid_email}")
    sleep 6
    @app.desktop_car_landing.verify_taken_action_right("valid")
  end

  scenario 'Verify user can not cancel policy if email not valid' do
    @app.desktop_car_landing.cancel_policy("#{@invalid_email}")
    @app.desktop_car_landing.verify_taken_action_right("invalid")
  end

  scenario 'Verify user can not cancel policy if email not registered' do
    @app.desktop_car_landing.cancel_policy("#{@none_registered_email}")
    @app.desktop_car_landing.verify_taken_action_right("none_registered")
  end

  scenario 'Verify user can not cancel policy if email is empty' do
    @app.desktop_car_landing.cancel_policy("")
    @app.desktop_car_landing.verify_taken_action_right("empty")
  end
end