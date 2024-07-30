require_relative '../../../../base_page.rb'

class MobileCarInsurancePayment < BasePage

  set_url ('insurance/{country}/{language}/car/checkout/paynow')

  element :card_number_field, :css, "input[placeholder='Card Number']"
  element :expiry_date_field, :css, "[id='expiry_date']"
  element :cvv_field, :css, "[id='card_security_code']"
  element :card_holder_name_field, :css, "[id='card_holder_name']"
  element :pay_button, :css, "[type='button']"
  element :add_on_sub_total, :xpath, "(//*[contains(text(),'Sub Total')])[2]//ancestor::div[@class='grid-cell']//following-sibling::div//div//span"
  elements :warranty_add_on, :xpath, "//span[contains(text(),'Warranty 1500 AED (max limit is 5000 per claim)')]"

  def make_payment(card_number, expiry_date, cvv, card_holder)
    card_number_field.fill_in(with: card_number)
    expiry_date_field.fill_in(with: expiry_date)
    cvv_field.fill_in(with: cvv)
    card_holder_name_field.fill_in(with: card_holder)
    scroll_to(pay_button)
    click_on(pay_button, false)
  end
end