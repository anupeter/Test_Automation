require_relative '../../../../../spec_helper'

feature 'Car PA Test Suite', :skip_qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'TC-PA-005 - No repurchase for Active PA customer' do

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
                                                                              "#{$test_data['LOCALEXP']}", "#{$test_data['LASTCLAIM']}","#{$test_data['NOCLAIMYEARS']}","#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
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
      expect(page).to have_xpath("//span[@class='insurance-label' and text()='First Month Free! ']")
      sleep 1
      @app.desktop_car_insurance_checkout.secure_checkout
      page.scroll_to(find(:css, "[type='button']"))
      @app.desktop_car_insurance_payment.make_payment("#{$test_data['CARD_NUMBER']}", "#{$test_data['EXPIRY_DATE']}", "#{$test_data['CVV']}", "#{$test_data['CARD_HOLDER']}")
      @app.desktop_car_insurance_thank_you.verify_payment_received
      policy_number = @app.desktop_car_insurance_thank_you.reference_number.text.split(//).last(8).join.gsub(/[^0-9]/, '').to_i
      set_host ("broker")
      @app.desktop_broker_login.load
      @app.desktop_broker_login.login("anu.peter@yallacompare.com", "BrookerYC@2020")
      set_host ("broker")
      @app.broker_car_insurance_policy_details.load type: "car", policy_number: "#{policy_number}"

      @app.broker_car_insurance_policy_details.change_policy_status("RECEIVED")
      @app.broker_car_insurance_policy_details.verify_policy_status("RECEIVED")

      @app.broker_car_insurance_policy_details.issue_policy("123456", "50000", "30000", "123", "WDBWK56F87F163868","123","345","784198809876543")
      sleep 1
      @app.broker_car_insurance_policy_details.verify_policy_status("ISSUED")

      #second purchase
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
                                                                              "#{$test_data['LOCALEXP']}", "#{$test_data['LASTCLAIM']}","#{$test_data['NOCLAIMYEARS']}","#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
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

