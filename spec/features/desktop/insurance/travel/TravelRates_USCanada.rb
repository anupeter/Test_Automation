require_relative '../../../../spec_helper'

feature 'Travel Insurance Buy Quote Test Suite', :uae do
  before do
    set_host ("travel")
    @app.desktop_travel_landing.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    @name = "#{$test_data['NAME']}"
    @email = "#{$test_data['VALID_EMAIL']}"
    @mobile = "#{$test_data["#{ENV['COUNTRY']}"]['TRAVEL_PHONE_NUMBER']}"
    @card_number = "#{$test_data['CARD_NUMBER']}"
    @expiry_date = "#{$test_data['EXPIRY_DATE']}"
    @cvv = "#{$test_data['CVV']}"
    @card_holder = "#{$test_data['CARD_HOLDER']}"
  end

  scenario '7 Days' do

    PRODUCT=$test_data['US_CANADA_PRODUCT']
    @app.desktop_travel_landing.choose_travel_country("otherCountries")
    page.find(:xpath,"//div[@class='country-label']/span[text()='USA']").click
    page.find(:xpath,"//div[@class='country-label']/span[text()='Canada']").click
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.start_date_travel.click
    @app.desktop_travel_landing.calendar_switch.click
    sleep 1

    @app.desktop_travel_landing.day_one.click
    @app.desktop_travel_landing.day_five.click

    sleep 2
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)

    #page.find(:xpath,"//label[text()='#{$test_data['PRODUCT']}']/parent::div/following-sibling::div[6]/button[text()='Select quote']").click
    PRODUCT.size.times do |i|
      first_price = page.find(:xpath,"//label[text()='#{PRODUCT[i]}']/parent::div/following-sibling::div[5]/span").text.gsub(/[^0-9]/, '').to_i

      #total_price = [124,98,134,106]
      total_price = [115,89,124,97]
      expect(total_price[i]).to eq(first_price)
    end
  end

  scenario '14 Days' do
    #PRODUCT=['Program 1 - Individual Worldwide Excluding USA & Canada without Covid','Program 2 - Individual Worldwide Excluding USA & Canada without Covid','Program 1 - Individual Worldwide Excluding USA & Canada with Covid','Program 2 - Individual Worldwide Excluding USA & Canada with Covid']
    PRODUCT=$test_data['US_CANADA_PRODUCT']
    @app.desktop_travel_landing.choose_travel_country("otherCountries")
    page.find(:xpath,"//div[@class='country-label']/span[text()='USA']").click
    page.find(:xpath,"//div[@class='country-label']/span[text()='Canada']").click
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.start_date_travel.click
    @app.desktop_travel_landing.calendar_switch.click
    sleep 1

    @app.desktop_travel_landing.day_one.click
    @app.desktop_travel_landing.day_14.click

    sleep 2
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)

    PRODUCT.size.times do |i|
      first_price = page.find(:xpath,"//label[text()='#{PRODUCT[i]}']/parent::div/following-sibling::div[5]/span").text.gsub(/[^0-9]/, '').to_i

      #total_price = [124,98,134,106]
      total_price = [154,119,166,129]
      expect(total_price[i]).to eq(first_price)
    end
  end

  scenario '21 Days' do
    #PRODUCT=['Program 1 - Individual Worldwide Excluding USA & Canada without Covid','Program 2 - Individual Worldwide Excluding USA & Canada without Covid','Program 1 - Individual Worldwide Excluding USA & Canada with Covid','Program 2 - Individual Worldwide Excluding USA & Canada with Covid']
    PRODUCT=$test_data['US_CANADA_PRODUCT']
    @app.desktop_travel_landing.choose_travel_country("otherCountries")
    page.find(:xpath,"//div[@class='country-label']/span[text()='USA']").click
    page.find(:xpath,"//div[@class='country-label']/span[text()='Canada']").click
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.start_date_travel.click
    @app.desktop_travel_landing.calendar_switch.click
    sleep 1

    @app.desktop_travel_landing.day_one.click
    @app.desktop_travel_landing.day_21.click

    sleep 2
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)

    PRODUCT.size.times do |i|
      first_price = page.find(:xpath,"//label[text()='#{PRODUCT[i]}']/parent::div/following-sibling::div[5]/span").text.gsub(/[^0-9]/, '').to_i

      #total_price = [124,98,134,106]
      total_price = [207,162,223,174]
      expect(total_price[i]).to eq(first_price)
    end
  end

  scenario '30 Days' do
    #PRODUCT=['Program 1 - Individual Worldwide Excluding USA & Canada without Covid','Program 2 - Individual Worldwide Excluding USA & Canada without Covid','Program 1 - Individual Worldwide Excluding USA & Canada with Covid','Program 2 - Individual Worldwide Excluding USA & Canada with Covid']
    PRODUCT=$test_data['US_CANADA_PRODUCT']
    @app.desktop_travel_landing.choose_travel_country("otherCountries")
    page.find(:xpath,"//div[@class='country-label']/span[text()='USA']").click
    page.find(:xpath,"//div[@class='country-label']/span[text()='Canada']").click
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.start_date_travel.click
    @app.desktop_travel_landing.calendar_switch.click
    sleep 1

    @app.desktop_travel_landing.day_one.click
    @app.desktop_travel_landing.day_30.click

    sleep 2
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)

    PRODUCT.size.times do |i|
      first_price = page.find(:xpath,"//label[text()='#{PRODUCT[i]}']/parent::div/following-sibling::div[5]/span").text.gsub(/[^0-9]/, '').to_i

      #total_price = [124,98,134,106]
      total_price = [268,208,289,224]
      expect(total_price[i]).to eq(first_price)
      end
  end

  scenario '45 days' do
    # PRODUCT=['Program 1 - Individual Worldwide Excluding USA & Canada without Covid','Program 2 - Individual Worldwide Excluding USA & Canada without Covid','Program 1 - Individual Worldwide Excluding USA & Canada with Covid','Program 2 - Individual Worldwide Excluding USA & Canada with Covid']
    PRODUCT=$test_data['US_CANADA_PRODUCT']
    @app.desktop_travel_landing.choose_travel_country("otherCountries")
    page.find(:xpath,"//div[@class='country-label']/span[text()='USA']").click
    page.find(:xpath,"//div[@class='country-label']/span[text()='Canada']").click
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.start_date_travel.click
    @app.desktop_travel_landing.calendar_switch.click
    sleep 1

    @app.desktop_travel_landing.day_one.click
    @app.desktop_travel_landing.day_45.click

    sleep 2
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)

    PRODUCT.size.times do |i|
      first_price = page.find(:xpath,"//label[text()='#{PRODUCT[i]}']/parent::div/following-sibling::div[5]/span").text.gsub(/[^0-9]/, '').to_i

      #total_price = [124,98,134,106]
      total_price= [337,260,363,280]
      expect(total_price[i]).to eq(first_price)
    end
  end

  scenario '60 Days' do
    #PRODUCT=['Program 1 - Individual Worldwide Excluding USA & Canada without Covid','Program 2 - Individual Worldwide Excluding USA & Canada without Covid','Program 1 - Individual Worldwide Excluding USA & Canada with Covid','Program 2 - Individual Worldwide Excluding USA & Canada with Covid']
    PRODUCT=$test_data['US_CANADA_PRODUCT']
    @app.desktop_travel_landing.choose_travel_country("otherCountries")
    page.find(:xpath,"//div[@class='country-label']/span[text()='USA']").click
    page.find(:xpath,"//div[@class='country-label']/span[text()='Canada']").click
    @app.desktop_travel_landing.fill_main_contact_details("#{@name}", "#{@mobile}", "#{@email}")
    @app.desktop_travel_landing.start_date_travel.click
    @app.desktop_travel_landing.calendar_switch.click
    sleep 1

    @app.desktop_travel_landing.day_one.click
    @app.desktop_travel_landing.day_60.click

    sleep 2
    @app.desktop_travel_landing.accept_declaration("yes")
    @app.desktop_travel_landing.click_on("show_me_quotes", true)

    PRODUCT.size.times do |i|
      first_price = page.find(:xpath,"//label[text()='#{PRODUCT[i]}']/parent::div/following-sibling::div[5]/span").text.gsub(/[^0-9]/, '').to_i

      #total_price = [124,98,134,106]
      total_price=[401,311,431,335]
      expect(total_price[i]).to eq(first_price)
    end

  end

end

