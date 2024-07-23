require_relative '../../../../base_page.rb'

class DesktopHealthInsuranceCheckout < BasePage

  set_url ('insurance/{country}/{language}/health/checkout')

  element :total_price, :xpath, "//p[@class='price']"
  element :i_understand, :xpath, "//input[@class='insurance-checkbox required-checkbox']//following-sibling::span[contains(text(),'understand')]"
  element :proceed_to_payment, :css, "button[class='button-accent']"

  def secure_checkout
    # javascript_click(i_understand)
    sleep 2 #TODO: find a workaround to remove sleep
    proceed_to_payment.click
  end
end