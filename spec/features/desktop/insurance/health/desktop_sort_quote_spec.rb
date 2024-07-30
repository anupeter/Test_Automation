require_relative '../../../../spec_helper'

feature 'Health Insurance Sort Quote Test Suite', :uae do
  before do
    set_host ("cover")
    @app.desktop_health_landing.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
    @gender = 'Male'
    @cityId = 'Dubai'
    @nationality = 'Turkish'
    @relationship = 'Child'
    @insuranceFor = 'No'
    @salaryOver4k = 'Yes'
  end

  scenario 'Verify user can sort quotes in desc order' do
    @app.desktop_health_landing.get_quotes.click
    @app.desktop_health_insurance_details.choose_member_details("#{@nationality}", "#{@gender}", "#{@cityId}", "#{@name}",
                                                               "#{@email}", "#{@mobile}", "#{@relationship}",
                                                               "#{@insuranceFor}", "#{@salaryOver4k}", "2005", "7",
                                                               "1", "Your family")
    @app.desktop_health_insurance_details.one_more_step_button.click
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{@email}", "#{@mobile}", "#{@cityId}", "#{@relationship}")
    @app.desktop_health_quote_list.all_good_button.click
    @app.desktop_health_quote_list.sort_order("desc")
    @app.desktop_health_quote_list.verify_sorting("desc")
  end

  scenario 'Verify user can sort quotes in asc order' do
    @app.desktop_health_landing.get_quotes.click
    @app.desktop_health_insurance_details.choose_member_details("#{@nationality}", "#{@gender}", "#{@cityId}", "#{@name}",
                                                               "#{@email}", "#{@mobile}", "#{@relationship}",
                                                               "#{@insuranceFor}", "#{@salaryOver4k}", "2005", "7",
                                                               "1", "Your family")
    @app.desktop_health_insurance_details.one_more_step_button.click
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{@email}", "#{@mobile}", "#{@cityId}", "#{@relationship}")
    @app.desktop_health_quote_list.all_good_button.click
    @app.desktop_health_quote_list.sort_order("asc")
    @app.desktop_health_quote_list.verify_sorting("asc")
  end
end