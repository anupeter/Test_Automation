require_relative '../../../../../spec_helper'

/*feature 'Car Insurance Sorting Quotes Test Suite', :egy,:skip_uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
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
    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{car}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}", "#{expiredPolicy}", "#{carCondition}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click
    @app.desktop_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}",
                                                                    "#{@name}", "#{@email}",
                                                                    "#{@mobile}",
                                                                    "#{claimsLastYear}")
    @app.desktop_car_insurance_driver_details.get_quotes_button.click
  end

  scenario 'Verify user can sort quotes by price' do
    sleep 2 #TODO: add validation and wait for element method
    @app.desktop_car_insurance_quotes_details.sort_order
    @app.desktop_car_insurance_quotes_details.verify_sorting
  end
end
*/