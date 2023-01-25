require_relative '../../../../../spec_helper'

/*feature 'Car Insurance Buy Quote Negative Test Suite', :uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  #scenario 'Verify fully comprehensive quote not exist', :skip_egy, :uae do
  scenario 'Verify fully comprehensive quote not exist' do
    car = '2002'
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
    sleep 6
    #@app.desktop_car_insurance_quotes_details.verify_quotes_details("#{car}","#{make}", "#{modelMaster}", "#{model}", "#{city}", "Yes", "Turkey", "#{firstLicenseCountry}", "#{intExp}", "#{localExp}", "#{lastClaim}", "#{@name}", "#{@email}", "#{@mobile}", "#{claimsLastYear}" )
    page.scroll_to(@app.desktop_car_insurance_quotes_details.all_good_button)
    @app.desktop_car_insurance_quotes_details.click_on("all_good_button", true)
    @app.desktop_car_insurance_quotes_details.filter_quotes("Policy Feature","Fully Comprehensive")
    expect(@app.desktop_car_insurance_quotes_details.no_quote_message).to have_text("No quote available for activated filters, ", wait: 30)
  end

  scenario 'Verify there is no available quote' do
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
    expect(@app.desktop_car_insurance_quotes_details.zero_quote_message).to have_text("Sorry, We cannot process your application online. This could be due to either one of the following:", wait: 30)
  end
end
*/