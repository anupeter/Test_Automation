#!/usr/bin/env ruby

require_relative '../../../../../../spec_helper'

feature 'Car Insurance Get Quote Test Suite', :skip_qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'TC-001 Car age validation' do


    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{$test_data['YEAR']}", "#{$test_data['MAKE']}", "#{$test_data['MODELMASTER']}", "#{$test_data['MODEL']}",
                                                                      "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                      "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click

    @app.desktop_car_insurance_driver_details.choose_driver_details("#{$test_data['NATIONALITY']}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                    "#{$test_data['LOCALEXP']}", "#{$test_data['LASTCLAIM']}", "#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
                                                                    "#{@name}", "#{@email}", "#{@mobile}")
    @app.desktop_car_insurance_driver_details.get_quotes_button.click
    @app.desktop_pre_quotes_page.trim_selection_dropdown

    #sleep 2 #TODO: add validation and wait for element method
    @app.desktop_car_insurance_quotes_details.all_good_button.click
    sleep 2 #TODO: find a workaround to remove sleep
    page.scroll_to(find(:xpath, "//span[@class='max-width-250px' and text()=' Adamjee Insurance Insurance Company Test']"))
    @app.desktop_car_insurance_quotes_details.filter_quotes("Insurer", "Adamjee Insurance Insurance Company Test")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.verify_filter_applied("Insurer", "Adamjee Insurance Insurance Company Test")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.filter_quotes("Repair By", "approvedGarage")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.verify_filter_applied("Repair By", "approvedGarage")
    sleep 2 #TODO: find a workaround to remove sleep
    page.scroll_to(find(:xpath,"//div[@class='text-left vatMessage-exclusive mb-10']"))
    page.find(:xpath,"//li[@class='breadcrumbs__crumb breadcrumbs__crumb--visited']/a[text()='Vehicle >']").click


    #Maximum Car Age


    #page.execute_script "window.scrollBy(0,1268)"
    #page.find(:css,"button[class='button-accent']").click

    page.scroll_to(find(:xpath,"//span[@id='select2-lastClaimPeriod-container']"))
    page.find(:xpath,"//span[@id='select2-lastClaimPeriod-container']").click
    page.scroll_to(find(:xpath,"//select[@name='dob_day']"))
    page.find(:xpath,"//select[@name='dob_day']").click


    @app.desktop_car_insurance_driver_details.get_quotes_button.click

    @app.desktop_pre_quotes_page.trim_selection_dropdown
    @app.desktop_car_insurance_quotes_details.all_good_button.click
    sleep 2 #TODO: find a workaround to remove sleep
    page.scroll_to(find(:xpath, "//span[@class='max-width-250px' and text()=' Adamjee Insurance Insurance Company Test']"))
    @app.desktop_car_insurance_quotes_details.filter_quotes("Insurer", "Adamjee Insurance Insurance Company Test")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.verify_filter_applied("Insurer", "Adamjee Insurance Insurance Company Test")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.filter_quotes("Repair By", "approvedGarage")
    sleep 2 #TODO: find a workaround to remove sleep
    @app.desktop_car_insurance_quotes_details.verify_filter_applied("Repair By", "approvedGarage")

  end


end