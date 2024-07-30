require_relative '../../../../spec_helper'

feature 'Home Insurance Buy Quote Test Suite', :uae do
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

  scenario 'Verify user can buy home insurance with registered email address' do
    @app.desktop_home_landing.click_on("get_quotes", true)
    @app.desktop_home_insurance_details.fill_policy_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_home_insurance_details.continue_button.click
    first_price = @app.desktop_home_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_home_quote_list.price.click
    total_price = @app.desktop_home_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_home_insurance_checkout.secure_checkout
    @app.desktop_home_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_home_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_home_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(4).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.desktop_broker_home_insurance_policy_details.load type: "home", policy_number: "#{policy_number}"
    @app.desktop_broker_home_insurance_policy_details.upload_a_file
    @app.desktop_broker_home_insurance_policy_details.change_policy_status("RECEIVED")
    @app.desktop_broker_home_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.desktop_broker_home_insurance_policy_details.upload_policy
    @app.desktop_broker_home_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.desktop_broker_home_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify user can buy home insurance with non-registered email address' do
    time = Time.new.to_i
    email = "cansu_" + "#{time}" + "@yallacompare.com"
    @app.desktop_home_landing.click_on("get_quotes", true)
    @app.desktop_home_insurance_details.fill_policy_details("#{@name}", "#{@mobile}", "#{email}")
    @app.desktop_home_insurance_details.continue_button.click
    first_price = @app.desktop_home_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_home_quote_list.price.click
    total_price = @app.desktop_home_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_home_insurance_checkout.secure_checkout
    @app.desktop_home_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_home_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_home_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(4).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.desktop_broker_home_insurance_policy_details.load type: "home", policy_number: "#{policy_number}"
    @app.desktop_broker_home_insurance_policy_details.upload_a_file
    @app.desktop_broker_home_insurance_policy_details.change_policy_status("RECEIVED")
    @app.desktop_broker_home_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.desktop_broker_home_insurance_policy_details.upload_policy
    @app.desktop_broker_home_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.desktop_broker_home_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify order summary is correct' do
    @app.desktop_home_landing.click_on("get_quotes", true)
    @app.desktop_home_insurance_details.fill_policy_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_home_insurance_details.continue_button.click
    @app.desktop_home_quote_list.price.click
    @app.desktop_home_insurance_checkout.secure_checkout
    premium_price = @app.desktop_home_insurance_payment.premium_price.text.gsub(/[^0-9]/, '').to_i
    calculated_vat = (premium_price * 0.05).ceil
    vat_in_summary = @app.desktop_home_insurance_payment.vat.text.gsub(/[^0-9]/, '').to_i
    expect(calculated_vat).to eq(vat_in_summary)
    total_price_in_summary = @app.desktop_home_insurance_payment.total_price.text.gsub(/[^0-9]/, '').to_i
    calculated_total_price = calculated_vat + premium_price
    expect(calculated_total_price).to eq(total_price_in_summary)
  end
end