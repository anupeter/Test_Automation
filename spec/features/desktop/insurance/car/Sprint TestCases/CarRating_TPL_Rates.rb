require_relative '../../../../../spec_helper'

feature 'Car Insurance Get Quote Test Suite', :skip_qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
  end

  scenario 'Minimum Premium Self Declaration' do

    Last_Claim= $test_data['Last_Claim']
    Make= $test_data['MAKE_SALOON']
    Model= $test_data['Model_SALOON']
    Trim= $test_data['Trim_SALOON']
    tpl= $test_data['tpl_SALOON']
    Make.size.times do |j|

      set_host ("cover")
      @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
      @name = "#{$test_data['NAME']}"
      @email = "#{$test_data['VALID_EMAIL']}"
      @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
      @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{$test_data['YEAR']}", "#{Make[j]}", "#{Model[j]}", "#{Trim[j]}",
                                                                        "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                        "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")

      @app.desktop_car_insurance_vehicle_details.continue_button.click

      ((Last_Claim.size)-3).times do |i|

        @app.desktop_car_insurance_driver_details.choose_driver_details("#{$test_data['NATIONALITY']}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                        "#{$test_data['LOCALEXP']}", "#{Last_Claim[i]}", "#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
                                                                        "#{@name}", "#{@email}", "#{@mobile}")
        @app.desktop_car_insurance_driver_details.get_quotes_button.click
        #@app.desktop_pre_quotes_page.trim_selection_dropdown


        sleep 2 #TODO: add validation and wait for element method

        @app.desktop_car_insurance_quotes_details.all_good_button.click
        #@app.desktop_car_insurance_quotes_details.srp_page.click
        sleep 2 #TODO: find a workaround to remove sleep
        page.scroll_to(find(:xpath, "//span[@class='max-width-250px' and text()=' #{$test_data['PROVIDER']}']"))
        @app.desktop_car_insurance_quotes_details.filter_quotes("Insurer", "#{$test_data['PROVIDER']}")
        sleep 2 #TODO: find a workaround to remove sleep
        @app.desktop_car_insurance_quotes_details.verify_filter_applied("Insurer", "#{$test_data['PROVIDER']}")
        sleep 2 #TODO: find a workaround to remove sleep
        @app.desktop_car_insurance_quotes_details.filter_quotes("Tpl", "Third Party Only")
        sleep 2 #TODO: find a workaround to remove sleep
        page.scroll_to(find(:xpath,"//h1[text()='Scroll down to see all Quotes']"))
        tpl_price = @app.desktop_car_insurance_quotes_details.tpl_price.text.gsub(/[^0-9]/, '')
        expect(tpl_price).to eq("#{tpl[j]}")
        page.scroll_to(find(:xpath,"//div[@class='text-left vatMessage-exclusive mb-10']"))
        @app.desktop_car_insurance_quotes_details.driver_bc.click


      end


    end

  end


  scenario 'Minimum Premium NCD Proof' do
    Claim_Proof= $test_data['Claim_Proof']
    Make= $test_data['MAKE_SALOON']
    Model= $test_data['Model_SALOON']
    Trim= $test_data['Trim_SALOON']
    tpl= $test_data['tpl_SALOON']
    Make.size.times do |j|

      set_host ("cover")
      @app.desktop_car_insurance_vehicle_details.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
      @name = "#{$test_data['NAME']}"
      @email = "#{$test_data['VALID_EMAIL']}"
      @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
      @app.desktop_car_insurance_vehicle_details.choose_vehicle_details("#{$test_data['YEAR']}", "#{Make[j]}", "#{Model[j]}", "#{Trim[j]}",
                                                                        "#{$test_data['CITY']}", "#{$test_data['FIRSTCAR']}", "#{$test_data['NONGCC']}", "#{$test_data['THIRDPARTY']}",
                                                                        "#{$test_data['OLDAGENCY']}",  "#{$test_data['CARCONDITION']}")

      @app.desktop_car_insurance_vehicle_details.continue_button.click

      ((Claim_Proof.size)-3).times do |i|

        @app.desktop_car_insurance_driver_details.choose_driver_details_for_ncd("#{$test_data['NATIONALITY']}", "#{$test_data['FIRSTLICENSECOUNTRY']}", "#{$test_data['INTEXP']}",
                                                                                "#{$test_data['LOCALEXP']}", "#{$test_data['LASTCLAIM']}","#{Claim_Proof[i]}","#{$test_data['COVERPREFERENCE']}","#{$test_data['DOBDAY']}","#{$test_data['DOBMONTH']}","#{$test_data['DOBYEAR']}",
                                                                                "#{@name}", "#{@email}", "#{@mobile}")
        @app.desktop_car_insurance_driver_details.get_quotes_button.click
        #@app.desktop_pre_quotes_page.trim_selection_dropdown

        sleep 10 #TODO: add validation and wait for element method

        @app.desktop_car_insurance_quotes_details.all_good_button.click
        #@app.desktop_car_insurance_quotes_details.srp_page.click
        sleep 2 #TODO: find a workaround to remove sleep
        page.scroll_to(find(:xpath, "//span[@class='max-width-250px' and text()=' #{$test_data['PROVIDER']}']"))
        @app.desktop_car_insurance_quotes_details.filter_quotes("Insurer", "#{$test_data['PROVIDER']}")
        sleep 2 #TODO: find a workaround to remove sleep
        @app.desktop_car_insurance_quotes_details.verify_filter_applied("Insurer", "#{$test_data['PROVIDER']}")
        sleep 2 #TODO: find a workaround to remove sleep
        @app.desktop_car_insurance_quotes_details.filter_quotes("Tpl", "Third Party Only")
        sleep 2 #TODO: find a workaround to remove sleep
        page.scroll_to(find(:xpath,"//h1[text()='Scroll down to see all Quotes']"))
        tpl_price = @app.desktop_car_insurance_quotes_details.tpl_price.text.gsub(/[^0-9]/, '')
        expect(tpl_price).to eq("#{tpl[j]}")
        page.scroll_to(find(:xpath,"//div[@class='text-left vatMessage-exclusive mb-10']"))
        @app.desktop_car_insurance_quotes_details.driver_bc.click


      end


    end

  end

end
