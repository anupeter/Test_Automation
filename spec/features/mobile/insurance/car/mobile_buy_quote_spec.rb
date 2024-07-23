require_relative '../../../../spec_helper'

feature 'Car Insurance Buy Quote Test Suite', :uae do
  before do
    set_host ("cover")
    @app.mobile_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
  end

  scenario 'Verify user can buy car insurance' do
    car = '2015'
    make= 'Audi'
    modelMaster = 'A7'
    model = '3.0 TFSI - 6 Cylinder'
    carCondition = 'Good'
    city = 'Abu Dhabi'
    firstCar = 'True'
    nonGcc ='False'
    thirdParty = 'False'
    oldAgency = 'False'
    expiredPolicy = 'False'
    nationality = 'Turkish'
    firstLicenseCountry = 'United Arab Emirates'
    intExp = '2 to 3 Years'
    localExp = '1 to 2 Years'
    lastClaim ='0-12 Months Ago'
    coverPrefence = 'Not Sure'
    claimsLastYear = '2'
    @app.mobile_car_insurance_vehicle_details.choose_vehicle_details("#{car}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}", "#{expiredPolicy}", "#{carCondition}")
    @app.mobile_car_insurance_vehicle_details.continue_button.click
    @app.mobile_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}",
                                                                    "#{@name}", "#{@email}",
                                                                    "#{@mobile}",
                                                                    "#{claimsLastYear}")
    @app.mobile_car_insurance_driver_details.get_quotes_button.click
    if ENV['COUNTRY'].downcase == 'uae'
      @app.mobile_car_insurance_quotes_details.verify_quotes_details("#{car}","#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "No", "Turkey",
                                                                      "#{firstLicenseCountry}", "#{intExp}", "#{localExp}",
                                                                      "#{lastClaim}", "#{@name}",
                                                                      "#{@email}", "#{@mobile}", "#{claimsLastYear}" )
      @app.mobile_car_insurance_quotes_details.all_good_button.click
    end
    sleep 1 #TODO: find a workaround to remove sleep
    first_price =  @app.mobile_car_insurance_quotes_details.price.text.gsub(/[^0-9]/, '').to_i
    @app.mobile_car_insurance_quotes_details.buy_now[0].click
    sleep 1 #TODO: find a workaround to remove sleep
    total_price = @app.mobile_car_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.mobile_car_insurance_checkout.secure_checkout
    @app.mobile_car_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.mobile_car_insurance_thank_you.verify_payment_received
    policy_number = @app.mobile_car_insurance_thank_you.reference_number.text.split(//).last(8).join.gsub(/[^0-9]/, '').to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.mobile_broker_car_insurance_policy_details.load type: "car", policy_number: "#{policy_number}"
    @app.mobile_broker_car_insurance_policy_details.verify_policy_status("PAID")
  end

  scenario 'Verify user can buy car insurance with new email address' do
    car = '2015'
    make= 'Audi'
    modelMaster = 'A7'
    model = '3.0 TFSI - 6 Cylinder'
    carCondition = 'Good'
    city = 'Abu Dhabi'
    firstCar = 'True'
    nonGcc ='False'
    thirdParty = 'False'
    oldAgency = 'False'
    expiredPolicy = 'False'
    nationality = 'Turkish'
    firstLicenseCountry = 'United Arab Emirates'
    intExp = '2 to 3 Years'
    localExp = '1 to 2 Years'
    lastClaim ='0-12 Months Ago'
    coverPrefence = 'Not Sure'
    claimsLastYear = '2'
    time = Time.new.to_i
    email = "cansu_" + "#{time}" + "@yallacompare.com"
    @app.mobile_car_insurance_vehicle_details.choose_vehicle_details("#{car}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}", "#{expiredPolicy}", "#{carCondition}")
    @app.mobile_car_insurance_vehicle_details.continue_button.click
    @app.mobile_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}",
                                                                    "#{@name}", "#{email}",
                                                                    "#{@mobile}",
                                                                    "#{claimsLastYear}")
    @app.mobile_car_insurance_driver_details.get_quotes_button.click
    if ENV['COUNTRY'].downcase == 'uae'
      @app.mobile_car_insurance_quotes_details.verify_quotes_details("#{car}","#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "No", "Turkey",
                                                                      "#{firstLicenseCountry}", "#{intExp}", "#{localExp}",
                                                                      "#{lastClaim}", "#{@name}",
                                                                      "#{email}", "#{@mobile}", "#{claimsLastYear}" )
      @app.mobile_car_insurance_quotes_details.all_good_button.click
    end
    sleep 1 #TODO: find a workaround to remove sleep
    page.scroll_to(@app.mobile_car_insurance_quotes_details.comprehensive_agency_repair)
    sleep 2
    first_price =  @app.mobile_car_insurance_quotes_details.price.text.gsub(/[^0-9]/, '').to_i
    @app.mobile_car_insurance_quotes_details.buy_now[0].click
    sleep 1 #TODO: find a workaround to remove sleep
    total_price = @app.mobile_car_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.mobile_car_insurance_checkout.secure_checkout
    @app.mobile_car_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.mobile_car_insurance_thank_you.verify_payment_received
    policy_number = @app.mobile_car_insurance_thank_you.reference_number.text.split(//).last(8).join.gsub(/[^0-9]/, '').to_i
    set_host ("broker")
    @app.mobile_broker_login.load
    @app.mobile_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.mobile_broker_car_insurance_policy_details.load type: "car", policy_number: "#{policy_number}"
    @app.mobile_broker_car_insurance_policy_details.verify_policy_status("PAID")
  end
end