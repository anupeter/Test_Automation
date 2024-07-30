require_relative '../../../base_page.rb'

class DesktopFzPayment < BasePage

  element :card_holder,:css,"[id='cardName']"
  element :card_number,:css,"[id='checkout-frames-card-number']"
  element :expiry_date,:css,"[id='checkout-frames-expiry-date']"
  element :cvv,:css,"[id='checkout-frames-cvv']"
  element :pay_checkbox,:xpath,"//input[@class='Checkboxstyles__CheckboxInput-sc-dho2no-1 fodRlJ']"
  element :pay_button,:xpath,"//button/span[contains(text(),'Pay')]"
  element :continue_merchant,:xpath,"//button[text()='Continue to merchant']"
  element :success_message,:xpath,"//h1[text()='Thank you! Payment was successful.']"

  def payment

    card_holder.send_keys("Test")

    within_frame(find(:xpath,"//iframe[@id='cardNumber']")) do
      card_number.send_keys("4005550000000001")
    end
    within_frame(find(:xpath,"//iframe[@id='expiryDate']")) do
      expiry_date.send_keys("0826")
    end
    within_frame(find(:xpath,"//iframe[@id='cvv']")) do
      cvv.send_keys("123")
    end
    sleep 1
    #page.switch_to.default_content
    page.scroll_to(find(:xpath,"//a[text()='Terms and Conditions']"))
    page.find(:xpath, '//input[@type="checkbox" and @id="terms-and-conditions-agreed"]', visible: false).click
    pay_button.click
    sleep 4
      #expect(page).to have_text("Thank you! Payment was successful.")


  end
end
