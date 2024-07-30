require_relative '../../../../base_page.rb'

class DesktopHomeInsurancePayment < BasePage

  set_url ('insurance/{country}/{language}/home/checkout/paynow')

  element :card_number_field, :css, "input[placeholder='Card Number']"
  element :expiry_date_field, :css, "[id='expiry_date']"
  element :cvv_field, :css, "[id='card_security_code']"
  element :card_holder_name_field, :css, "[id='card_holder_name']"
  element :pay_button, :css, "[type='button']"
  element :premium_price, :xpath, "(//div[@class='grid-cell'][2]/div[@class='text text--bold text--right'])[1]"
  element :total_price, :css, ".text.text--bold.text--right.text--margin.text--padding-horizontal > .text.text--clr-accent"
  element :vat, :xpath, "(//div[@class='grid-cell'][2]/div[@class='text text--bold text--right'])[2]"

  ##breadcrumbs
  element :breadcrumb_quotes, :css, "[href='/insurance/uae/en/home/quotes']"
  element :breadcrumb_details, :css, "[href='/insurance/uae/en/home/details']"

  def make_payment(card_number, expiry_date, cvv, card_holder)
    card_number_field.fill_in(with: card_number)
    expiry_date_field.fill_in(with: expiry_date)
    cvv_field.fill_in(with: cvv)
    card_holder_name_field.fill_in(with: card_holder)
    scroll_to(pay_button)
    click_on(pay_button, false)
  end
end