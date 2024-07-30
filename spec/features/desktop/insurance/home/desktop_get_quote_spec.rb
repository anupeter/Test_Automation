require_relative '../../../../spec_helper'

feature 'Home Insurance Get Quote Test Suite', :uae do
  before do
    set_host ("cover")
    @app.desktop_home_landing.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['VALID_PHONE_NUMBER']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
  end

  scenario 'Verify user can get home insurance with registered email address' do
    @app.desktop_home_landing.click_on("get_quotes", true)
    @app.desktop_home_insurance_details.fill_policy_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_home_insurance_details.continue_button.click
    page.assert_selector(:xpath, '//button[@class="button-accent"]', minimum: 1)
  end

  scenario 'Verify user can get home insurance with non-registered email address' do
    time = Time.new.to_i
    email = "cansu_" + "#{time}" + "@yallacompare.com"
    @app.desktop_home_landing.click_on("get_quotes", true)
    @app.desktop_home_insurance_details.fill_policy_details("#{@name}", "#{@mobile}", "#{email}")
    @app.desktop_home_insurance_details.continue_button.click
    page.assert_selector(:xpath, '//button[@class="button-accent"]', minimum: 1)
  end

  scenario 'Verify home insurance breadcrumbs are working as expected' do
    @app.desktop_home_landing.click_on("get_quotes", true)
    @app.desktop_home_insurance_details.fill_policy_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_home_insurance_details.continue_button.click
    first_price = @app.desktop_home_quote_list.price.text.gsub(/[^0-9]/, '').to_i
    @app.desktop_home_quote_list.price.click
    total_price = @app.desktop_home_insurance_checkout.total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price).to eq(first_price)
    @app.desktop_home_insurance_payment.breadcrumb_quotes.click
    url = current_url().gsub('staging:Stage9870@', '')
    expect(url).to include('https://yallacompare.org/insurance/uae/en/home/quotes')
    page.assert_selector(:xpath, '//button[@class="button-accent"]', minimum: 1)
    @app.desktop_home_quote_list.breadcrumb_details.click
    url = current_url().gsub('staging:Stage9870@', '')
    expect(url).to include('https://yallacompare.org/insurance/uae/en/home/details')
    page.assert_selector(:css, 'input[id="name"]', minimum: 1)
  end
end