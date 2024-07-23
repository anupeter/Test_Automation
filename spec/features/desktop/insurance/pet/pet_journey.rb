require_relative '../../../../spec_helper'

feature 'submitting the form', :uae do

  before do
    set_host("pet")
    @app.pet_user_journey.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @pet_name="#{$test_data['PET_NAME']}"
    @customer_name="#{$test_data['CUSTOMER_NAME']}"
    @phone_number="#{$test_data['PHONE_NUMBER']}"
    @pet_email="#{$test_data['PET_EMAIL']}"
  end

  scenario do
    @app.pet_user_journey.fill_form("#{@pet_name}","#{@customer_name}","#{@phone_number}","#{@pet_email}")

  end
end
