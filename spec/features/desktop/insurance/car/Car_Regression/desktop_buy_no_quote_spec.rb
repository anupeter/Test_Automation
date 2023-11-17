require_relative '../../../../../spec_helper'

feature 'Car Insurance Buy Quote Negative Test Suite', :uae, :regression do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end


  scenario 'TC-CAR-003 Verify NO_QUOTE scenario' do
    car = '2007'
    make= 'Bugatti'
    modelMaster = 'Veyron'
    model = '8.0TC V16 4WD'
    carCondition = 'Good'
    city = 'Dubai'
    firstCar = 'True'
    nonGcc ='True'
    thirdParty = 'True'
    oldAgency = 'False'
    nationality = 'Indian'
    firstLicenseCountry = 'United Arab Emirates'
    intExp = '0 to 6 Months'
    localExp = '0 to 6 Months'
    lastClaim ='Never'
    coverPrefence = 'Fully Comprehensive'
    dobDay = '2'
    dobMonth = '4'
    dobYear = '2001'
    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{car}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}","#{carCondition}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click
    @app.desktop_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}","#{dobDay}","#{dobMonth}","#{dobYear}",
                                                                    "#{@name}", "#{@email}",
                                                                    "#{@mobile}")
    @app.desktop_car_insurance_driver_details.click_on("get_quotes_button", true)
    sleep 2
    expect(@app.desktop_car_insurance_quotes_details.zero_quote_message).to have_text("Sorry, We cannot process your application online. This could be due to either one of the following:", wait: 30)
  end
end
