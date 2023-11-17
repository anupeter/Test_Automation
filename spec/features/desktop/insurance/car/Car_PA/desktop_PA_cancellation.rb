require_relative '../../../../../spec_helper'

feature 'Car PA Test Suite', :skip_qat, :uae do
  scenario 'TC-PA-004 - PA Cancellation'do
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("anu.peter@yallacompare.com", "BrookerYC@2020")
    visit 'https://broker.testingyalla.xyz/pa/list'
    @app.broker_car_insurance_policy_details.pa_search_box.send_keys("#{$test_data['RENEWAL_EMAIL']}")
    @app.broker_car_insurance_policy_details.pa_search_button.click
    page.find(:xpath,"(//th[text()='ISSUED']/parent::tr/th)[1]").click
    @app.broker_car_insurance_policy_details.cancel_payfort.click
    @app.broker_car_insurance_policy_details.cancel_remarks.send_keys("Cancelled")
    @app.broker_car_insurance_policy_details.cancel_yes.click
    expect(@app.broker_car_insurance_policy_details.current_status).to have_text("CANCEL")

    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("2023", "#{$test_data['MAKE']}", "#{$test_data['MODELMASTER']}", "#{$test_data['MODEL']}",
                                                                      "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                      "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")
    @app.desktop_car_insurance_vehicle_details.continue_button.click

    @app.desktop_car_insurance_driver_details.choose_driver_details_for_ncd("#{$test_data['NATIONALITY']}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                            "#{$test_data['LOCALEXP']}", "#{$test_data['LASTCLAIM']}","#{$test_data['NOCLAIMYEARS']}","#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
                                                                            "#{$test_data['NAME']}", "#{$test_data['RENEWAL_EMAIL']}", "#{$test_data['RENEWAL_MOBILE']}")
    @app.desktop_car_insurance_driver_details.get_quotes_button.click
    @app.desktop_pre_quotes_page.trim_selection_dropdown

    sleep 2 #TODO: add validation and wait for element method
    @app.desktop_car_insurance_quotes_details.all_good_button.click

    sleep 10 #TODO: find a workaround to remove sleep
    page.scroll_to(find(:xpath,"//h1[text()='Scroll down to see all Quotes']"))
    @app.desktop_car_insurance_quotes_details.buy_now[0].click
    sleep 2
    page.scroll_to(find(:css,"div[class=' text-center']"))
    expect(page).to have_text("Personal Accident 24/7")


  end

end
