
require_relative '../../../../base_page.rb'

class DesktopTravelLanding < BasePage

  set_url ('')

  #selection of travel country
  element :schengen_countries,  :css, "[data-rb-event-key='schengenCountries']"
  element :hajjumrah_countries, :css, "[data-rb-event-key='hajjUmrah']"
  element :arab_countries, :css, "[data-rb-event-key='arabCountries']"
  element :worldwide, :css, "[data-rb-event-key='otherCountries']"

  #Main contact details
  element :name_field,  :css, "[name='fullName']"
  element :phone_number, :css, "[name='PhoneNumber2']"
  element :email_field, :css, "[name='emailAddress']"
  element :start_day, :xpath, "//td[contains(@class,'CalendarDay__today')]"
  element :end_day, :xpath, "(//td[contains(@class,'CalendarDay__lastDayOfWeek')])[9]"
  #trip details
  element :add_traveler, :css, "[class='css-1sm21yy']"
  element :travel_start_date, :css, "[name='travel_start_date_id']"
  element :travel_end_date, :css, "[name='travel_end_date_id']"
  element :declaration_checkbox, :css, "[id='uaeResidenceDeclaration']"

  element :start_date_travel,:xpath,"//div[@class='DateInput DateInput_1']/input[@id='travel_start_date_id']"
  element :calendar_switch,:xpath,"//div[@aria-label='Move forward to switch to the next month.']"
  element :day_one,:xpath,"(//td[text()='1'])[2]"
  element :day_five,:xpath,"(//td[text()='5'])[2]"
  element :day_14,:xpath,"(//td[text()='13'])[2]"
  element :day_21,:xpath,"(//td[text()='20'])[2]"
  element :day_30,:xpath,"(//td[text()='25'])[2]"
  element :day_45,:xpath,"(//td[text()='10'])[3]"
  element :day_60,:xpath,"(//td[text()='25'])[3]"



  element :show_me_quotes, :css, "[type='submit']"

  def choose_travel_country(country)
    click_on(find(:css, "[data-rb-event-key='#{country}']"), false)
  end

  def fill_main_contact_details(name, mobile, email)
    name_field.set(name)
    phone_number.native.clear
    phone_number.set(mobile)
    email_field.set(email)
  end

  def choose_traveling_date
    click_on(travel_start_date, false)
    click_on(start_day, false)
    click_on(end_day, false)
  end

  def accept_declaration(option)
    if option == "yes"
      click_on(declaration_checkbox, false)
    else
      puts("Please make sure declaration checked")
    end
  end
end