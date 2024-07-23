require_relative '../../base_page.rb'

class DesktopHomePage < BasePage

  set_url ('{country}/{language}')

  element :insurance_tab, :xpath, "//a[@href='/insurance/uae/en/hub/']"
  element :car_insurance, :xpath, "//a[@href='/insurance/uae/en/car/' and @class='navMenu__item']"
  element :health_insurance, :xpath, "//a[@href='/insurance/uae/en/health/' and @class='navMenu__item']"
  element :home_insurance, :xpath, "//a[@href='/insurance/uae/en/home-insurance/' and @class='navMenu__item']"
  element :life_insurance, :xpath, "//a[@href='/insurance/uae/en/life/' and @class='navMenu__item']"
  element :travel_insurance, :xpath, "//a[@href='/insurance/uae/en/travel/' and @class='navMenu__item']"

  def verify_each_page_navigation
    category_array = ["car_insurance", "health_insurance", "home_insurance", "life_insurance", "travel_insurance"]
    category_array.map do |type|
      insurance_tab = page.driver.browser.find_element(:css, "[data-target='#Insurance']")
      page.driver.browser.action.move_to(insurance_tab).perform
      click_on(type, true)
      url = current_url().gsub('staging:Stage9870@', '')
      case type
      when "car_insurance"
        expect(url).to include('https://yallacompare.org/insurance/uae/en/car/')
      when "health_insurance"
        expect(url).to include('https://yallacompare.org/insurance/uae/en/health/')
      when "home_insurance"
        expect(url).to include('https://yallacompare.org/insurance/uae/en/home/')
      when "life_insurance"
        expect(url).to include('https://yallacompare.org/insurance/uae/en/life/')
      when "travel_insurance"
        expect(url).to include('https://yallacompare.org/insurance/uae/en/travel/')
        sleep 1
      end
      page.driver.browser.navigate().back()
    end
  end
end