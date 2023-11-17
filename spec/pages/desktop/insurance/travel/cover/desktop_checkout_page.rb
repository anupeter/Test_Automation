
require_relative '../../../../base_page.rb'

class DesktopTravelInsuranceCheckout < BasePage

  set_url ('insurance/{country}/{language}/travel/checkout')

  element :total_price, :xpath, "//h1[@class='css-1xwjt85' and text()='Quote price']/following-sibling::span"

  #Travelers Details
  element :title, :css, "[name='title']"
  element :gender, :css, "[name='gender']"
  element :first_name, :css, "[name='firstName']"
  element :last_name, :css, "[name='lastName']"
  element :passport_number, :css, "[name='identificationNumber']"
  element :email_field, :css, "[name='email']"
  element :declaration_checkbox, :css, "[id='declaration']"
  element :checkout_button, :css, "[type='submit']"

  def fill_traveler_details (title_option, gender_option, name, surname, passport, email)
    click_on(title, false)
    click_on(find(:xpath, "//option[text()='#{title_option}']"), false)
    click_on(gender, false)
    click_on(find(:xpath, "//option[text()='#{gender_option}']"), false)
    first_name.set(name)
    last_name.set(surname)
    passport_number.set(passport)
    email_field.set(email)
  end

  def accept_declaration(option)
    if option == "yes"
      click_on(declaration_checkbox, false)
    else
      puts("Please make sure declaration checked")
    end
  end
end

