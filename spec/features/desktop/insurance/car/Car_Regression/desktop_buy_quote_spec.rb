require_relative '../../../../../spec_helper'

feature 'Car Insurance Buy Quote Test Suite', :uae , :regression do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
  end


scenario 'TC-CAR-002 - To get a quote for a new user , purchase and issue the policy' do
    car = '2015'
    make = 'Audi'
    modelMaster = 'A7'
    model = '3.0 TFSI - 6 Cylinder'
    carCondition = 'Good'
    city = 'Abu Dhabi'
    firstCar = 'False'
    nonGcc = 'False'
    thirdParty = 'False'
    oldAgency = 'False'
    nationality = 'Pakistani'
    firstLicenseCountry = 'United Arab Emirates'
    intExp = '2 to 3 Years'
    localExp = '3 to 4 Years'
    lastClaim = '25-36 Months Ago'
    coverPrefence = 'Fully Comprehensive'
    dobDay = '4'
    dobMonth = '3'
    dobYear = '1988'
    time = Time.new.to_i
    email = "auto_user" + "#{time}" + "@test.com"
    mobile = "52" + "#{time}"
    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{car}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}", "#{carCondition}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click
    @app.desktop_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}",
                                                                    "#{dobDay}","#{dobMonth}","#{dobYear}",
                                                                    "#{@name}", "#{email}", "#{mobile}")
    @app.desktop_car_insurance_driver_details.click_on("get_quotes_button", true)
    @app.desktop_pre_quotes_page.trim_selection_dropdown
    sleep 30
    @app.desktop_car_insurance_quotes_details.click_on("all_good_button", true)

    sleep 1 #TODO: find a workaround to remove sleep
    first_price = @app.desktop_car_insurance_quotes_details.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_car_insurance_quotes_details.buy_now[0].click
    sleep 1 #TODO: find a workaround to remove sleep
    total_price = @app.desktop_car_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_car_insurance_checkout.secure_checkout
    @app.desktop_car_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_car_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_car_insurance_thank_you.reference_number.text.split(//).last(8).join.gsub(/[^0-9]/, '').to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("anu.peter@yallacompare.com", "BrookerYC@2020")
    set_host ("broker")
    @app.broker_car_insurance_policy_details.load type: "car", policy_number: "#{policy_number}"
    @app.broker_car_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_car_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_car_insurance_policy_details.issue_policy("policy_#{policy_number}", "2500", "30000", "123", "WDBWK56F87F163868","123","345","784198809876543")
    sleep 1
    @app.broker_car_insurance_policy_details.verify_policy_status("ISSUED")
end

end
