require_relative '../../../../base_page.rb'

class MobileHealthQuoteList < BasePage

  set_url ('insurance/{country}/{language}/health')

  element :all_good_button, :css, ".button-accent.px-15.w-auto.py-5"
  element :price, :xpath, "(//button[@class='button-accent button--healthQuote'])[2]"
  elements :all_prices, :xpath, "//button[@class='button-accent button--healthQuote']"

  #quote modal
  element :quote_modal, :css, "div[class='healthMemberSummary container-fluid pb-10']"
  element :name_field, :xpath, "//div[@class='row'][2]/div[@class='col-sm-5 col-md-7']"
  element :email_field, :xpath, "//div[@class='row'][3]/div[@class='col-sm-5 col-md-7']"
  element :mobile_field, :xpath, "//div[@class='row'][2]/div[@class='col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-0']"
  element :emirate_field, :xpath, "//div[@class='row'][3]/div[@class='col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-0']"
  element :gender_field, :css, "div[class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0']"
  element :nationality_field, :css, "div[class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0 ']"
  element :relationship_field, :xpath, "(//div[@class='row']/div[@class='col-sm-5 col-md-6 '])[2]"

  element :sort_desc, :xpath, "//*[contains(text(),'Total Price')]"

  def choose_insurance_option(option)
    click_on(insurance_selection_dropdown, false)
    click_on(find(:xpath, "//li[@class='select2-results__option' and text()='#{option}']"), false)
  end

  def verify_quotes_details(name, email, mobile, emirate, relationship)
    wait_for_element(quote_modal)
    expect(name_field).to have_text("#{name}")
    expect(email_field).to have_text("#{email}")
    expect(mobile_field).to have_text("#{mobile}")
    expect(emirate_field).to have_text("#{emirate}")
    expect(relationship_field).to have_text("#{relationship}")
  end

  def sort_order(option)
    click_on(sort_desc, false)
    click_on(sort_desc, false) if option == 'asc'
  end

  def verify_sorting(option)
    price = []
    all_prices.size.times do |i|
      price << ((all_prices)[i]).text.gsub(/[^0-9]/, '').to_i
    end
    expect(price.sort).to eq(price) if option == 'asc'
    expect(price.sort.reverse).to eq(price) if option == 'desc'
  end
end