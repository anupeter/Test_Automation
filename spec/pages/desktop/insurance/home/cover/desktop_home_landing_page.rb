require_relative '../../../../base_page.rb'

class DesktopHomeLanding < BasePage

  set_url ('insurance/{country}/{language}/home')

  element :get_quotes, :css, "a[href='/insurance/uae/en/home/details']"

end