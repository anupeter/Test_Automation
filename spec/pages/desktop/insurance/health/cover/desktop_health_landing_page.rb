require_relative '../../../../base_page.rb'

class DesktopHealthLanding < BasePage

  set_url ('insurance/{country}/{language}/health')

  element :get_quotes, :css, "[class='landingPageHero__button button button-accent applyNowForm__input healthApplicationType']"
  element :insurance_selection_dropdown, :css, "[class='select2-selection select2-selection--single']"
  element :yourself, :css, "li[id='select2-applicationType-dk-result-qmsl-YOURSELF']"
  element :family, :css, "li[id='select2-applicationType-3m-result-ir5h-FAMILY']"

  def choose_insurance_option(option)
    click_on(insurance_selection_dropdown, false)
    click_on(find(:xpath, "//li[@class='select2-results__option' and text()='#{option}']"), false)
  end
end