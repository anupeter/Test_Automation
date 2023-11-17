
require_relative '../../../../../spec_helper'

feature 'Car PA Test Suite', :skip_qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'TC-PA-003 - To verify PA not available above age 65' do

    Agency_Years=[2023]
    Agency_Years.size.times do |i|
      set_host ("cover")
      @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
      @name = "#{$test_data['NAME']}"
      @email = "#{$test_data['VALID_EMAIL']}"
      @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
      @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{Agency_Years[i]}", "#{$test_data['MAKE']}", "#{$test_data['MODELMASTER']}", "#{$test_data['MODEL']}",
                                                                        "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                        "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")
      @app.desktop_car_insurance_vehicle_details.continue_button.click

      @app.desktop_car_insurance_driver_details.choose_driver_details_for_ncd("#{$test_data['NATIONALITY']}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                              "#{$test_data['LOCALEXP']}", "#{$test_data['LASTCLAIM']}","#{$test_data['NOCLAIMYEARS']}","#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['PA_MAX_DOBYEAR']}",
                                                                              "#{@name}", "#{@email}", "#{@mobile}")
      @app.desktop_car_insurance_driver_details.get_quotes_button.click
      @app.desktop_pre_quotes_page.trim_selection_dropdown

      sleep 2 #TODO: add validation and wait for element method
      @app.desktop_car_insurance_quotes_details.all_good_button.click

      sleep 10 #TODO: find a workaround to remove sleep
      page.scroll_to(find(:xpath,"//h1[text()='Scroll down to see all Quotes']"))
      @app.desktop_car_insurance_quotes_details.buy_now[0].click
      sleep 2
      page.scroll_to(find(:css,"div[class=' text-center']"))
      expect(page).not_to have_text("Personal Accident 24/7")

    end


  end




end
