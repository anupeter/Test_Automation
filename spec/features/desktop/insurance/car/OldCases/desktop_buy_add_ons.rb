require_relative '../../../../../spec_helper'

feature 'Car Insurance Buy Car Insurance Add-Ons Test Suite', :uae, :skip_egy do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
  end

  scenario 'Verify user can add add-ons from checkboxes for car insurance' do
    car = '2015'
    make= 'Audi'
    modelMaster = 'A7'
    model = '3.0 TFSI - 6 Cylinder'
    carCondition = "Good"
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
    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{car}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}", "#{expiredPolicy}", "#{carCondition}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click
    @app.desktop_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}",
                                                                    "#{@name}", "#{@email}",
                                                                    "#{@mobile}",
                                                                    "#{claimsLastYear}")
    @app.desktop_car_insurance_driver_details.click_on("get_quotes_button", true)
    sleep 6
    # @app.desktop_car_insurance_quotes_details.verify_quotes_details("#{car}","#{make}", "#{modelMaster}", "#{model}", "#{city}", "No", "Turkey", "#{firstLicenseCountry}", "#{intExp}", "#{localExp}", "#{lastClaim}", "#{@name}", "#{@email}", "#{@mobile}", "#{claimsLastYear}" )
    page.scroll_to(@app.desktop_car_insurance_quotes_details.all_good_button)
    @app.desktop_car_insurance_quotes_details.click_on("all_good_button", true)
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.buy_now[0].click
    add_on_checkout =  @app.desktop_car_insurance_checkout.check_add_ons
    @app.desktop_car_insurance_checkout.secure_checkout
    add_on_payment = @app.desktop_car_insurance_payment.add_on_sub_total.text.gsub(/[^0-9]/, '').to_i
    expect(add_on_payment).to eq(add_on_checkout)
end



scenario 'Verify user can add add-ons for car warranty' do
    car = '2015'
    make= 'Audi'
    modelMaster = 'A7'
    model = '3.0 TFSI - 6 Cylinder'
    carCondition = "Good"
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
    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{car}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}", "#{expiredPolicy}", "#{carCondition}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click
    @app.desktop_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}",
                                                                    "#{@name}", "#{@email}",
                                                                    "#{@mobile}",
                                                                    "#{claimsLastYear}")
    @app.desktop_car_insurance_driver_details.click_on("get_quotes_button", true)
    @app.desktop_car_insurance_quotes_details.verify_quotes_details("#{car}","#{make}", "#{modelMaster}", "#{model}",
                                                                    "#{city}", "No", "Turkey",
                                                                    "#{firstLicenseCountry}", "#{intExp}", "#{localExp}",
                                                                    "#{lastClaim}", "#{@name}",
                                                                    "#{@email}", "#{@mobile}", "#{claimsLastYear}" )
    page.scroll_to(@app.desktop_car_insurance_quotes_details.all_good_button)
    @app.desktop_car_insurance_quotes_details.click_on("all_good_button", true)
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.buy_now[0].click
    @app.desktop_car_insurance_checkout.choose_add_on_dropdown("warrantyCar", "1500 AED")
    expect(@app.desktop_car_insurance_payment.warranty_add_on.size).to be >=1
  end
end
