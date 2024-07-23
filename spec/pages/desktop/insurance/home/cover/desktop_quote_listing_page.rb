require_relative '../../../../base_page.rb'

class DesktopHomeQuoteList < BasePage

  set_url ('insurance/{country}/{language}/home')

  element :price, :xpath, "(//button[@class='button-accent'])[2]"
  elements :all_prices, :xpath, "//button[@class='button-accent']"

  ##breadcrumbs
  element :breadcrumb_details, :css, "[href='/insurance/uae/en/home/details']"
end