require_relative '../../../../../spec_helper'

feature 'Car Insurance Get Quote Test Suite', :skip_qat, :uae, :regression do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'TC-CAR-001 - To get a quote for an existing user' do
    year = '2021'
    make = 'Toyota'
    modelMaster = 'Fortuner '
    model = '4.0L GXR'
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
    dobDay = '4'
    dobMonth = '3'
    dobYear = '1988'

    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{year}", "#{make}", "#{modelMaster}", "#{model}",
                                                                      "#{city}", "#{firstCar}", "#{nonGcc}", "#{thirdParty}",
                                                                      "#{oldAgency}",  "#{carCondition}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click
    @app.desktop_car_insurance_driver_details.choose_driver_details("#{nationality}", "#{firstLicenseCountry}", "#{intExp}",
                                                                    "#{localExp}", "#{lastClaim}", "#{coverPrefence}","#{dobDay}","#{dobMonth}","#{dobYear}",
                                                                    "#{@name}", "#{@email}", "#{@mobile}")
    @app.desktop_car_insurance_driver_details.get_quotes_button.click
    @app.desktop_pre_quotes_page.trim_selection_dropdown
    sleep 30 #TODO: find a workaround to remove sleep
    # if ENV['COUNTRY'].downcase == 'uae'
    # @app.desktop_car_insurance_quotes_details.verify_quotes_details("#{year}", "#{make}", "#{modelMaster}", "#{model}", "#{city}", "No", "India", "#{firstLicenseCountry}", "#{intExp}", "#{localExp}", "#{lastClaim}", "#{@name}", "#{@email}", "#{@mobile}")
    #end
    @app.desktop_car_insurance_quotes_details.all_good_button.click
  end
end