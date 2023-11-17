
require_relative '../../../../spec_helper'

feature 'Travel Insurance Buy Quote Test Suite', :uae do
  before do
    set_host ("travel")
    @app.desktop_travel_landing.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
  end

  scenario 'Verify user can buy travel insurance for a traveler' do
    @app.desktop_travel_landing.choose_travel_country("schengenCountries")
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)
    first_price = @app.desktop_travel_quote_list.quote_price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_travel_quote_list.select_quote.click
    total_price = @app.desktop_travel_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_travel_insurance_checkout.fill_traveler_details("Mr.", "Male", "Test", "Automation", "123456789", "#{@email}")
    @app.desktop_travel_insurance_checkout.accept_declaration("yes")
    @app.desktop_travel_insurance_checkout.click_on("checkout_button", true)
    @app.desktop_travel_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_travel_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_travel_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(4).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.broker_travel_insurance_policy_details.load type: "travel", policy_number: "#{policy_number}"
    @app.broker_travel_insurance_policy_details.upload_policy
    sleep 1 #TODO: find a workaround to remove sleep
    @app.broker_travel_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_travel_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_travel_insurance_policy_details.issue_policy("123456", "#{first_price}")
    @app.broker_travel_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify user can compare travel quotes' do
    @app.desktop_travel_landing.choose_travel_country("schengenCountries")
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)
    @app.desktop_travel_quote_list.compare_quotes(3)
  end

  scenario 'Verify order summary is correct' do
    @app.desktop_travel_landing.choose_travel_country("schengenCountries")
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)
    @app.desktop_travel_quote_list.select_quote.click
    @app.desktop_travel_insurance_checkout.fill_traveler_details("Mr.", "Male", "Test", "Automation", "123456789", "#{@email}")
    @app.desktop_travel_insurance_checkout.accept_declaration("yes")
    @app.desktop_travel_insurance_checkout.click_on("checkout_button", true)
    @app.desktop_travel_insurance_payment.click_on("order_summary_more_info", true)
    premium_price = @app.desktop_travel_insurance_payment.premium_price.text.gsub(/[^0-9]/, '').to_i
    calculated_vat = (premium_price * 0.05).ceil
    vat_in_summary = @app.desktop_travel_insurance_payment.vat.text.gsub(/[^0-9]/, '').to_i
    expect(calculated_vat).to eq(vat_in_summary)
    total_price_in_summary = @app.desktop_travel_insurance_payment.total_price.text.gsub(/[^0-9]/, '').to_i
    calculated_total_price = calculated_vat + premium_price
    expect(calculated_total_price).to eq(total_price_in_summary)
  end
end