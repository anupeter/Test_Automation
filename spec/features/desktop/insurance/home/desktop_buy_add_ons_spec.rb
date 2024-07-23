require_relative '../../../../spec_helper'

feature 'Home Insurance Buy Home Insurance Add-Ons Test Suite', :uae, :skip_egy do
  before do
    set_host ("cover")
    @app.desktop_home_landing.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
  end

  #TODO: add price verification after devs removed home insurance add-on from checkout page
  scenario 'Verify user can add add-on to home insurance' do
    @app.desktop_home_landing.click_on("get_quotes", true)
    @app.desktop_home_insurance_details.fill_policy_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_home_insurance_details.continue_button.click
    @app.desktop_home_quote_list.price.click
    @app.desktop_home_insurance_checkout.check_add_ons
    @app.desktop_home_insurance_checkout.secure_checkout
    expect(find(:xpath, '//span[contains(text(),"Domestic Helper")]').visible?).to be true
  end
end