require_relative '../../../../../spec_helper'

feature 'Car Insurance Get Quote Test Suite', :skip_qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'TC-CAR-001 - To get a quote for an existing user' do
    year = '2018'
    make = 'Audi'
    modelMaster = 'A7'
    model = '3.0 TFSI - 6 Cylinder'
    carCondition = 'Good'
    city = 'Abu Dhabi'
    firstCar = 'False'
    nonGcc = 'False'
    thirdParty = 'False'
    oldAgency = 'False'
    nationality = 'Indian'
    firstLicenseCountry = 'United Arab Emirates'
    intExp = '2 to 3 Years'
    localExp = '3 to 4 Years'
    lastClaim = 'Never'
    coverPrefence = 'Fully Comprehensive'

    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{year}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}",  "#{carCondition}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click
    @app.desktop_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}",
                                                                    "#{@name}", "#{@email}", "#{@mobile}")
    @app.desktop_car_insurance_driver_details.get_quotes_button.click
    # if ENV['COUNTRY'].downcase == 'uae'
    # @app.desktop_car_insurance_quotes_details.verify_quotes_details("#{year}", "#{make}", "#{modelMaster}", "#{model}", "#{city}", "No", "Turkey", "#{firstLicenseCountry}", "#{intExp}", "#{localExp}", "#{lastClaim}", "#{@name}", "#{@email}", "#{@mobile}", "#{claimsLastYear}")
    #end
  end
end
