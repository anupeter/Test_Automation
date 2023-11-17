
require_relative '../../../../base_page.rb'

class DesktopTravelQuoteList < BasePage

  set_url ('insurance/{country}/{language}/travel')

  element :select_quote, :xpath, "(//button[@type='submit'])[1]"
  element :schengen_quote,[:xpath,"//label[text()='Schengen']/parent::div/following-sibling::div[6]/button[text()='Select quote']"]
  element :quote_price, :xpath, "//h1[@class='css-kddxki' and text()='Quote price']/following-sibling::span[1]"
  elements :quote_prices, :xpath, "//h1[@class='css-1xwjt85' and text()='Quote price']/following-sibling::span"
  elements :compare_quotes_button, :xpath, "//a[@class='css-1wrmulo']"
  element :compare_quotes_main_button, :css, "[class='css-38j9ao']"

  #Elements on modal after clicking on compare quotes button
  elements :modal_quote_price, :xpath, "//div[@class='col' and text()='Quote price']/following-sibling::div/span"

  def compare_quotes (quotes_count)
    adding_quotes_to_compare (quotes_count)
    get_prices_from_modal (quotes_count)
    verify_quotes_added_to_modal (quotes_count)
  end

  def adding_quotes_to_compare (quotes_count)
    @main_page_price = []
    quotes_count.times do |i|
      @main_page_price << ((quote_prices)[i]).text.gsub(/[^0-9]/, '').to_i
      click_on((compare_quotes_button)[0], false)
    end
    click_on(compare_quotes_main_button, false)
    sleep 2 #TODO: find a workaround to remove sleep
  end

  def get_prices_from_modal (quotes_count)
    @modal_price = []
    quotes_count.times do |i|
      @modal_price << ((modal_quote_price)[i]).text.gsub(/[^0-9]/, '').to_i
    end
  end

  def verify_quotes_added_to_modal (quotes_count)
    quotes_count.times do |i|
      expect((@main_page_price)[i]).to eq((@modal_price)[i])
    end
  end
end