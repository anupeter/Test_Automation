require_relative '../../../../base_page.rb'

class MobileCarInsuranceCheckout < BasePage

  set_url ('insurance/{country}/{language}/car/checkout')


  elements :add_on_checkboxes, :xpath, "//div[@class='table-cell value top']/label[@class='checkbox']"
  elements :add_on_dropdowns, :css, "[class='select2-selection select2-selection--single']"
  elements :add_on_price, :css, "[class='table-cell value top'] [class='insurance-label']"
  element :total_price, :xpath, "//p[@class='price']"
  element :i_agree, :css, "[class='insurance-checkbox required-checkbox'] + *"
  element :proceed_to_payment, :css, "button[class='button-accent']"

  def secure_checkout
    javascript_click(i_agree)
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

  def choose_add_on_dropdown(option, price)
    total_price_amount = total_price.text.gsub(/[^0-9]/, '').to_i
    case option
    when "warrantyCar"
      click_on(find(:css, "[id='select2-#{option}-container']"), false)
      sleep 1
      click_on(find(:xpath, "(//*[contains(text(),'Warranty 1500 AED (max limit is 5000 per claim)')])[2]"), false) if price == "1500 AED"
      click_on(find(:xpath, "(//*[contains(text(),'Warranty 2500 AED (max limit is 10,000 per claim)')])[2]"), false) if price == "2500 AED"
    end
    total_price_amount = total_price_amount + 1500 if price == "1500 AED"
    total_price_amount = total_price_amount + 2500 if price == "2500 AED"
    total_last_amount = total_price.text.gsub(/[^0-9]/, '').to_i
    expect(total_price_amount).to eq(total_last_amount)
    end
end