require_relative '../../../../../spec_helper'

feature 'Car Insurance Filter Quotes Test Suite', :uae, :skip_egy do
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
    @app.desktop_car_insurance_driver_details.get_quotes_button.click
    @app.desktop_car_insurance_quotes_details.verify_quotes_details("#{car}","#{make}", "#{modelMaster}", "#{model}",
                                                                    "#{city}", "No", "Turkey",
                                                                    "#{firstLicenseCountry}", "#{intExp}", "#{localExp}",
                                                                    "#{lastClaim}", "#{@name}",
                                                                    "#{@email}", "#{@mobile}", "#{claimsLastYear}" )
    $quote_id = current_url.gsub('https://stage-cover-1.testingyalla.xyz/insurance/uae/en/car/quotes/','')
  end

  scenario 'Verify user can filter car insurance quotes according to policy features- fully comprehensive' do
    sleep 2 #TODO: add validation and wait for element method
    @app.desktop_car_insurance_quotes_details.all_good_button.click
    @app.desktop_car_insurance_quotes_details.filter_quotes("policy feature","Fully Comprehensive")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.verify_filter_applied("Fully Comprehensive", 'true')
  end

  scenario 'Verify user can filter car insurance quotes according to policy features- third party only' do
    sleep 2 #TODO: add validation and wait for element method
    @app.desktop_car_insurance_quotes_details.all_good_button.click
    @app.desktop_car_insurance_quotes_details.filter_quotes("policy feature", "Third Party Only")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.verify_filter_applied("Third Party Only", 'true')
  end

  scenario 'Verify user can filter car insurance quotes according to insurer' do
    sleep 2 #TODO: add validation and wait for element method
    @app.desktop_car_insurance_quotes_details.all_good_button.click
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.filter_quotes("Insurer", "AMAN")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.verify_filter_applied("Insurer", "AMAN")
  end

  scenario 'Verify user can filter car insurance quotes for only takaful' do
    @app.desktop_car_insurance_quotes_details.all_good_button.click
      sleep 2 #TODO: find a workaround to remove sleep
      @app.desktop_car_insurance_quotes_details.filter_quotes("Only Takaful", '')
      sleep 2 #TODO: find a workaround to remove sleep
      @app.desktop_car_insurance_quotes_details.verify_filter_applied("Only Takaful", 'true')
  end
end
