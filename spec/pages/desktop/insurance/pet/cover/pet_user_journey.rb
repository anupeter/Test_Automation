require_relative '../../../../base_page.rb'

class PetUserJourney < BasePage
  set_url('https://stage-pet.testingyalla.xyz/uae/en/pet-insurance/pet-details')

  element :pet_name_field, :css, "[name='petName']"
  element :pet_type, :css, "label[for='petType_2']"
  element :pet_gender, :css, "label[for='gender_Boy']"
  element :pet_breed, :css, "label[for='gender_Mixed']"
  element :pet_breed_size, :css, "label[for='petBreed_21']"

  element :next_button, :xpath, "//button[@class='buttonStyle__Secondary-sc-1d6h79f-1 hFHBPr' and text()='Next']"
  element :skip_button, :xpath, "//button[@class='buttonStyle__Secondary-sc-1d6h79f-1 hFHBPr' and text()='Skip']"
  element :pet_customer_name_field, :css, "[id='name']"
  element :phone_number_field, :css, "[name='mobile']"
  element :email_field, :css, "[name='email']"
  element :submit_button, :xpath, "//button[@class='buttonStyle__Secondary-sc-1d6h79f-1 hFHBPr' and text()='Submit']"
  element :deductible_button, :xpath, "//a[@class='buttonStyle__Border-sc-1d6h79f-5 bKTHbX'][2]"
  element :bronze_button, :xpath, "//div[@class='tableQuotesStyle__TableCol-sc-1orj0mt-5 iSqwHU'][1]//button[@class='buttonStyle__Secondary-sc-1d6h79f-1 ilxsoo'][1]"
  element :tc_checkbox, :xpath, "//input[@name='terms&conditions']"


  element :card_number_field, :css, "input[placeholder='Card Number']"
  element :expiry_date_field, :css, "[id='expiry_date']"
  element :cvv_field, :css, "[id='card_security_code']"
  element :card_holder_name_field, :css, "[id='card_holder_name']"
  element :pay_button, :css, "[type='button']"





  def fill_form(pet_name,customer_name,phone_number,pet_email)
    pet_name_field.send_keys(pet_name)
    next_button.click
    pet_type.click
    next_button.click
    pet_gender.click
    next_button.click
    pet_breed.click
    next_button.click
    pet_breed_size.click
    next_button.click
    click_on(find(:css, "select[id='petAge']"), false)
    click_on(find(:xpath, "//select[@id='petAge']//option[@value='1']"),false)
    next_button.click
    skip_button.click
    next_button.click
    pet_customer_name_field.send_keys(customer_name)
    next_button.click
    click_on(find(:css, "select[name='phoneKey']"), false)
    click_on(find(:xpath, "//select[@name='phoneKey']//option[@value='50']"),false)
    phone_number_field.send_keys(phone_number)
    next_button.click
    email_field.send_keys(pet_email)
    submit_button.click
    deductible_button.click
    scroll_to(bronze_button)
    bronze_button.click
    tc_checkbox.click

  end

  def make_payment(card_number, expiry_date, cvv, card_holder)
    card_number_field.fill_in(with: card_number)
    expiry_date_field.fill_in(with: expiry_date)
    cvv_field.fill_in(with: cvv)
    card_holder_name_field.fill_in(with: card_holder)
    scroll_to(pay_button)
    click_on(pay_button, false)
  end

end
