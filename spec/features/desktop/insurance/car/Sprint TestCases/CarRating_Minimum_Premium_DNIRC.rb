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
          nonAR_quote_price_claim = @app.desktop_car_insurance_quotes_details.quote_price[0].text.gsub(/[^0-9]/, '')
          expect(nonAR_quote_price_claim).to eq("#{minimum_premium_claim[j]}")
        else
          nonAR_quote_price = @app.desktop_car_insurance_quotes_details.quote_price[0].text.gsub(/[^0-9]/, '')
          expect(nonAR_quote_price).to eq("#{minimum_premium_noClaim[j]}")
          puts nonAR_quote_price
          #agency_quote_price = @app.desktop_car_insurance_quotes_details.quote_price[1].text.gsub(/[^0-9]/, '')
          #expect(agency_quote_price).to eq("#{agency_minimum_premium[j]}")
        end
        @app.desktop_car_insurance_quotes_details.driver_bc.click
      end

    end
  end


  scenario 'Minimum Premium NCD Proof' do

    Claim_Proof = ['Yes - 1 year proof','Yes - 2 years proof','Yes - 3 years proof','Yes - 4 or more years proof']
    ((Claim_Proof.size)-3).times do |i|
      set_host ("cover")
      @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
      @name = "#{$test_data['NAME']}"
      @email = "#{$test_data['VALID_EMAIL']}"
      @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
      @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{$test_data['YEAR']}", "#{$test_data['MAKE']}", "#{$test_data['MODELMASTER']}", "#{$test_data['MODEL']}",
                                                                        "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                        "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")
      @app.desktop_car_insurance_vehicle_details.continue_button.click
      @app.desktop_car_insurance_driver_details.choose_driver_details_for_ncd("#{$test_data['NATIONALITY']}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                              "#{$test_data['LOCALEXP']}", "#{$test_data['LASTCLAIM']}","#{Claim_Proof[i]}","#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
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
      @app.desktop_car_insurance_quotes_details.filter_quotes("Repair By", "approvedGarage")
      sleep 2 #TODO: find a workaround to remove sleep
      @app.desktop_car_insurance_quotes_details.verify_filter_applied("Repair By", "approvedGarage")
      sleep 2 #TODO: find a workaround to remove sleep
      page.scroll_to(find(:xpath,"//h1[text()='Scroll down to see all Quotes']"))
      quote_price = @app.desktop_car_insurance_quotes_details.quote_price.text.gsub(/[^0-9]/, '')
      expect(quote_price).to eq("#{$test_data['minimum_premium']}")

    end
  end

end
