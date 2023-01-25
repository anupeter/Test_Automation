require_relative '../../../../base_page.rb'

class DesktopPreQuotesPage < BasePage

  set_url ('insurance/{country}/{language}/car/pre-quotes/{quote_id}')
  element :trim_button, [:css,"button[value='Show Me Quotes']"]
  #element :trim_dropdown, [:css,"span[id='select2-autodataVehicleTrim-container']"]
  def trim_selection_dropdown
  click_on(find(:css, "span[id='select2-autodataVehicleTrim-container']"), false)
  click_on(find(:xpath, "//ul[@class='select2-results__options']/li[2]"), false)
  click_on(find(:css, "button[value='Show Me Quotes']"), false)
  end


end
