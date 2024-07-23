require_relative '../../../../spec_helper'

feature 'Car Insurance Buy Quote Negative Test Suite' do
  before do
    set_host ("cover")
    @app.mobile_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'Verify fully comprehensive quote not exist', :uae, :skip_egy do
    car = '2001'
    make= 'Nissan'
    modelMaster = 'Maxima'
    model = 'S'
    carCondition = "Good"
    city = 'Abu Dhabi'
    firstCar = 'True'
    nonGcc ='False'
    thirdParty = 'True'
    oldAgency = 'False'
    expiredPolicy = 'True'
    nationality = 'Turkish'
    firstLicenseCountry = 'United Arab Emirates'
    intExp = '0 to 6 Months'
    localExp = '0 to 6 Months'
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
    @app.mobile_car_insurance_quotes_details.verify_quotes_details("#{car}","#{make}", "#{modelMaster}", "#{model}",
                                                                    "#{city}", "Yes", "Turkey",
                                                                    "#{firstLicenseCountry}", "#{intExp}", "#{localExp}",
                                                                    "#{lastClaim}", "#{@name}",
                                                                    "#{@email}", "#{@mobile}", "#{claimsLastYear}" )
    @app.mobile_car_insurance_quotes_details.click_on("all_good_button", true)
    @app.mobile_car_insurance_quotes_details.filter_quotes("Policy Feature","Fully Comprehensive")
    expect(@app.mobile_car_insurance_quotes_details.comprehensive_not_available).to have_text("Not Available")
  end

  scenario 'Verify there is no available quote', :uae, :egy do
    car = '2007'
    make= 'Bugatti'
    modelMaster = 'Veyron'
    model = '8.0TC V16 4WD'
    carCondition = 'Good'
    city = 'Abu Dhabi'
    firstCar = 'True'
    nonGcc ='True'
    thirdParty = 'True'
    oldAgency = 'False'
    expiredPolicy = 'True'
    nationality = 'Turkish'
    firstLicenseCountry = 'United Arab Emirates'
    intExp = '0 to 6 Months'
    localExp = '0 to 6 Months'
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
    expect(@app.mobile_car_insurance_quotes_details.zero_quote_message).to have_text("Sorry, We cannot process your application online. This could be due to either one of the following:", wait: 30)
  end
end