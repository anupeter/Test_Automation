require_relative '../../../../base_page.rb'

class DesktopHomeInsuranceCheckout < BasePage

  set_url ('insurance/{country}/{language}/home/checkout')

  element :total_price, :xpath, "//p[@class='price']"
  elements :add_on_checkboxes, :xpath, "//div[@class='table-cell value top']/label[@class='checkbox']"
  elements :add_on_price, :css, "[class='table-cell value top'] [class='insurance-label']"
  # element :i_agree, :xpath, "//input[@class='insurance-checkbox required-checkbox']//following-sibling::span[contains(text(),'agree')]"
  element :i_agree, :css, "[class='insurance-checkbox required-checkbox'] + *"
  element :proceed_to_payment, :css, "button[class='button-accent']"

  def secure_checkout
    sleep 2 #TODO: find a workaround to remove sleep
    proceed_to_payment.click
  end

  def check_add_ons
    total_price_amount = total_price.text.gsub(/[^0-9]/, '').to_i
    total_add_on_amount = 0
    add_on_checkboxes.size.times do |i|
      sleep 1
      click_on(add_on_checkboxes[i], false)
      total_add_on_amount += ((add_on_price)[i]).text.gsub(/[^0-9]/, '').to_i
    end
    total_price_amount = total_price_amount + total_add_on_amount
    total_last_amount = total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price_amount).to eq(total_last_amount)
    return total_add_on_amount
  end
end