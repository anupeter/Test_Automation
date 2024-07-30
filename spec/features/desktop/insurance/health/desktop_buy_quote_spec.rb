require_relative '../../../../spec_helper'

feature 'Health Insurance Buy Quote Test Suite', :uae do
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
  end

  scenario 'Verify user can buy health insurance for family' do
    gender = 'Male'
    cityId = 'Dubai'
    nationality = 'Turkish'
    relationship = 'Child'
    insuranceFor = 'No'
    salaryOver4k= 'Yes'
    @app.desktop_health_landing.click_on("get_quotes", true)
    @app.desktop_health_insurance_details.choose_member_details("#{nationality}", "#{gender}", "#{cityId}", "#{@name}",
                                                               "#{@email}", "#{@mobile}", "#{relationship}",
                                                               "#{insuranceFor}", "#{salaryOver4k}", "2005", "7", "1",
                                                               "Your family")
    @app.desktop_health_insurance_details.one_more_step_button.click
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{@email}", "#{@mobile}", "#{cityId}", "#{relationship}")
    page.scroll_to(@app.desktop_health_quote_list.all_good_button)
    @app.desktop_health_quote_list.click_on("all_good_button", true)
    first_price =  @app.desktop_health_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_health_quote_list.price.click
    total_price = @app.desktop_health_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_health_insurance_checkout.secure_checkout
    @app.desktop_health_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_health_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_health_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(5).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.broker_health_insurance_policy_details.load type: "health", policy_number: "#{policy_number}"
    @app.broker_health_insurance_policy_details.upload_a_file
    @app.broker_health_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.upload_policy
    @app.broker_health_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.broker_health_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify user can buy health insurance for yourself' do
    gender = 'Male'
    cityId = 'Dubai'
    nationality = 'Turkish'
    salaryOver4k= 'Yes'
    @app.desktop_health_landing.choose_insurance_option("Yourself")
    @app.desktop_health_landing.click_on("get_quotes", true)
    @app.desktop_health_insurance_details.choose_member_details("#{nationality}", "#{gender}", "#{cityId}", "#{@name}",
                                                               "#{@email}", "#{@mobile}", "", "", "#{salaryOver4k}", "2005", "7", "1", "Yourself")
    @app.desktop_health_insurance_details.one_more_step_button.click
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{@email}", "#{@mobile}", "#{cityId}", "")
    @app.desktop_health_quote_list.click_on("all_good_button", true)
    first_price =  @app.desktop_health_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_health_quote_list.price.click
    total_price = @app.desktop_health_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_health_insurance_checkout.secure_checkout
    @app.desktop_health_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_health_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_health_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(5).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.broker_health_insurance_policy_details.load type: "health", policy_number: "#{policy_number}"
    @app.broker_health_insurance_policy_details.upload_a_file
    @app.broker_health_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.upload_policy
    @app.broker_health_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.broker_health_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify user can buy health insurance for maid/driver' do
    gender = 'Male'
    cityId = 'Dubai'
    nationality = 'Turkish'
    salaryOver4k= 'Yes'
    @app.desktop_health_landing.choose_insurance_option("Your maid / driver")
    @app.desktop_health_landing.click_on("get_quotes", true)
    @app.desktop_health_insurance_details.choose_member_details("#{nationality}", "#{gender}", "#{cityId}", "#{@name}",
                                                               "#{@email}", "#{@mobile}", "", "", "#{salaryOver4k}", "1991", "7", "1", "Your maid / driver")
    @app.desktop_health_insurance_details.one_more_step_button.click
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{@email}", "#{@mobile}", "#{cityId}", "")
    page.scroll_to(@app.desktop_health_quote_list.all_good_button)
    @app.desktop_health_quote_list.click_on("all_good_button", true)
    first_price =  @app.desktop_health_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_health_quote_list.price.click
    total_price = @app.desktop_health_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_health_insurance_checkout.secure_checkout
    @app.desktop_health_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_health_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_health_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(5).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.broker_health_insurance_policy_details.load type: "health", policy_number: "#{policy_number}"
    @app.broker_health_insurance_policy_details.upload_a_file
    @app.broker_health_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.upload_policy
    @app.broker_health_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.broker_health_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify user can buy health insurance for family with non-existing email' do
    gender = 'Male'
    cityId = 'Dubai'
    nationality = 'Turkish'
    relationship = 'Child'
    insuranceFor = 'No'
    salaryOver4k= 'Yes'
    time = Time.new.to_i
    email = "cansu_" + "#{time}" + "@yallacompare.com"
    @app.desktop_health_landing.click_on("get_quotes", true)
    @app.desktop_health_insurance_details.choose_member_details("#{nationality}", "#{gender}", "#{cityId}", "#{@name}",
                                                                "#{email}", "#{@mobile}", "#{relationship}",
                                                                "#{insuranceFor}", "#{salaryOver4k}", "2005", "7", "1",
                                                                "Your family")
    @app.desktop_health_insurance_details.one_more_step_button.click
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{email}", "#{@mobile}", "#{cityId}", "#{relationship}")
    page.scroll_to(@app.desktop_health_quote_list.all_good_button)
    @app.desktop_health_quote_list.click_on("all_good_button", true)
    first_price =  @app.desktop_health_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_health_quote_list.price.click
    total_price = @app.desktop_health_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_health_insurance_checkout.secure_checkout
    @app.desktop_health_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_health_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_health_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(5).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.broker_health_insurance_policy_details.load type: "health", policy_number: "#{policy_number}"
    @app.broker_health_insurance_policy_details.upload_a_file
    @app.broker_health_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.upload_policy
    @app.broker_health_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.broker_health_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify user can buy health insurance for yourself with non-existing email' do
    gender = 'Male'
    cityId = 'Dubai'
    nationality = 'Turkish'
    salaryOver4k= 'Yes'
    time = Time.new.to_i
    email = "cansu_" + "#{time}" + "@yallacompare.com"
    @app.desktop_health_landing.choose_insurance_option("Yourself")
    @app.desktop_health_landing.click_on("get_quotes", true)
    @app.desktop_health_insurance_details.choose_member_details("#{nationality}", "#{gender}", "#{cityId}", "#{@name}",
                                                                "#{email}", "#{@mobile}", "", "", "#{salaryOver4k}", "2005", "7", "1", "Yourself")
    @app.desktop_health_insurance_details.one_more_step_button.click
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{email}", "#{@mobile}", "#{cityId}", "")
    @app.desktop_health_quote_list.click_on("all_good_button", true)
    first_price =  @app.desktop_health_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_health_quote_list.price.click
    total_price = @app.desktop_health_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_health_insurance_checkout.secure_checkout
    @app.desktop_health_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_health_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_health_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(5).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.broker_health_insurance_policy_details.load type: "health", policy_number: "#{policy_number}"
    @app.broker_health_insurance_policy_details.upload_a_file
    @app.broker_health_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.upload_policy
    @app.broker_health_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.broker_health_insurance_policy_details.verify_policy_status("ISSUED")
  end

  scenario 'Verify user can buy health insurance for maid/driver with non-existing email' do
    gender = 'Male'
    cityId = 'Dubai'
    nationality = 'Turkish'
    salaryOver4k= 'Yes'
    time = Time.new.to_i
    email = "cansu_" + "#{time}" + "@yallacompare.com"
    @app.desktop_health_landing.choose_insurance_option("Your maid / driver")
    @app.desktop_health_landing.click_on("get_quotes", true)
    @app.desktop_health_insurance_details.choose_member_details("#{nationality}", "#{gender}", "#{cityId}", "#{@name}",
                                                                "#{email}", "#{@mobile}", "", "", "#{salaryOver4k}", "1991", "7", "1", "Your maid / driver")
    @app.desktop_health_insurance_details.one_more_step_button.click
    sleep 1 #TODO: find a workaround to remove sleep
    @app.desktop_health_declaration_details.choose_option_from_radio
    @app.desktop_health_declaration_details.get_button.click
    @app.desktop_health_quote_list.verify_quotes_details("#{@name}", "#{email}", "#{@mobile}", "#{cityId}", "")
    page.scroll_to(@app.desktop_health_quote_list.all_good_button)
    @app.desktop_health_quote_list.click_on("all_good_button", true)
    first_price =  @app.desktop_health_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_health_quote_list.price.click
    total_price = @app.desktop_health_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_health_insurance_checkout.secure_checkout
    @app.desktop_health_insurance_payment.make_payment("#{@card_number}", "#{@expiry_date}", "#{@cvv}", "#{@card_holder}")
    @app.desktop_health_insurance_thank_you.verify_payment_received
    policy_number = @app.desktop_health_insurance_thank_you.reference_number.text.gsub(/[^0-9]/, '').split(//).last(5).join.to_i
    set_host ("broker")
    @app.desktop_broker_login.load
    @app.desktop_broker_login.login("cansu@yallacompare.com", "111111")
    set_host ("broker")
    @app.broker_health_insurance_policy_details.load type: "health", policy_number: "#{policy_number}"
    @app.broker_health_insurance_policy_details.upload_a_file
    @app.broker_health_insurance_policy_details.change_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.verify_policy_status("RECEIVED")
    @app.broker_health_insurance_policy_details.upload_policy
    @app.broker_health_insurance_policy_details.issue_policy("123456", "#{first_price}", "3", "2020-09-19")
    @app.broker_health_insurance_policy_details.verify_policy_status("ISSUED")
  end
end