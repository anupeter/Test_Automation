#!/usr/bin/env ruby

require_relative '../../../../../../spec_helper'

feature 'Car Insurance Get Quote Test Suite', :skip_qat ,:uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'TC-003 Claim Case Validation'  do


    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{$test_data['YEAR']}", "#{$test_data['MAKE']}", "#{$test_data['MODELMASTER']}", "#{$test_data['MODEL']}",
                                                                      "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                      "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click

    @app.desktop_car_insurance_driver_details.choose_driver_details("#{$test_data['NATIONALITY']}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                    "#{$test_data['LOCALEXP']}", "#{$test_data['CLAIM_CASE']}", "#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
                                                                    "#{@name}", "#{@email}", "#{@mobile}")
    @app.desktop_car_insurance_driver_details.get_quotes_button.click
    @app.desktop_pre_quotes_page.trim_selection_dropdown

    sleep 2 #TODO: add validation and wait for element method
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
    @app.desktop_car_insurance_quotes_details.approved_garage_filter.click
    @app.desktop_car_insurance_quotes_details.filter_quotes("Repair By", "maker")
    expect(@app.desktop_car_insurance_quotes_details.no_quote_message).to have_text("No quote available for activated filters, ", wait: 30)
    page.find(:xpath,"//span[@class='text-accent font-weight-bold pointer' and text()='Clear filters']").click

  end




end