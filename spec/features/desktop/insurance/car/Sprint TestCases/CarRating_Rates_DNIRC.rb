require_relative '../../../../../spec_helper'

feature 'Car Insurance Get Quote Test Suite', :skip_qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'Minimum Premium Self Declaration' , :skip_uae do

    Last_Claim= $test_data['Last_Claim']
    Nationality= $test_data['DNIRC_NATIONALITY']
    minimum_premium_claim= $test_data['minimum_premium_claim']
    minimum_premium_noClaim= $test_data['minimum_premium_noClaim']
    agency_minimum_premium= $test_data['agency_minimum_premium']
    sum_insured= $test_data['SUM_INSURED']
    rate_noClaim= $test_data['RATE_NOCLAIM']
    rate_Claim= $test_data['RATE_CLAIM']
    rate_agency= $test_data['RATE_AGENCY']
    Nationality.size.times do |j|
      set_host ("cover")
      @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
      @name = "#{$test_data['NAME']}"
      @email = "#{$test_data['VALID_EMAIL']}"
      @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
      @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{$test_data['YEAR']}", "#{$test_data['MAKE']}", "#{$test_data['MODELMASTER']}", "#{$test_data['MODEL']}",
                                                                        "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                        "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")
      @app.desktop_car_insurance_vehicle_details.continue_button.click


      Last_Claim.size.times do |i|

        @app.desktop_car_insurance_driver_details.choose_driver_details("#{Nationality[j]}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                        "#{$test_data['LOCALEXP']}", "#{Last_Claim[i]}", "#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
                                                                        "#{@name}", "#{@email}", "#{@mobile}")
        @app.desktop_car_insurance_driver_details.get_quotes_button.click
        #@app.desktop_pre_quotes_page.trim_selection_dropdown

        sleep 10 #TODO: add validation and wait for element method

        @app.desktop_car_insurance_quotes_details.all_good_button.click
        sleep 2 #TODO: find a workaround to remove sleep
        page.scroll_to(find(:xpath, "//span[@class='max-width-250px' and text()=' #{$test_data['PROVIDER']}']"))
        @app.desktop_car_insurance_quotes_details.filter_quotes("Insurer", "#{$test_data['PROVIDER']}")
        sleep 2 #TODO: find a workaround to remove sleep
        @app.desktop_car_insurance_quotes_details.verify_filter_applied("Insurer", "#{$test_data['PROVIDER']}")
        sleep 2 #TODO: find a workaround to remove sleep
        @app.desktop_car_insurance_quotes_details.filter_quotes("Policy Feature", "Fully Comprehensive")
        sleep 2 #TODO: find a workaround to remove sleep
        page.scroll_to(find(:xpath,"//h1[text()='Scroll down to see all Quotes']"))

        if i == 0
          nonAR_quote_price_claim = @app.desktop_car_insurance_quotes_details.quote_price[0].text.gsub(/[^0-9]/, '').to_i
          @app.desktop_car_insurance_quotes_details.calculate_premium("#{sum_insured}","#{rate_Claim[j]}",nonAR_quote_price_claim)
        else
          #agency_quote_price = @app.desktop_car_insurance_quotes_details.quote_price[1].text.gsub(/[^0-9]/, '').to_i
          #@app.desktop_car_insurance_quotes_details.calculate_premium("#{sum_insured}","#{rate_agency[j]}",agency_quote_price)
          nonAR_quote_price = @app.desktop_car_insurance_quotes_details.quote_price[0].text.gsub(/[^0-9]/, '').to_i
          @app.desktop_car_insurance_quotes_details.calculate_premium("#{sum_insured}","#{rate_noClaim[j]}",nonAR_quote_price)

        end
        @app.desktop_car_insurance_quotes_details.driver_bc.click
      end

    end
  end
end
