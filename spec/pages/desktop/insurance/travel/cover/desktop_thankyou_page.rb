
require_relative '../../../../base_page.rb'

class DesktopTravelInsuranceThankYou < BasePage

  set_url ('insurance/{country}/{language}/car/checkout/thankyou')

  element :success_message, :css, "h1[class='css-ghktei']"
  element :reference_number, :xpath, "//p[text()='Your policy reference number is: ']/span"

  def verify_payment_received
    expect(success_message).to have_text("Congratulations! The payment was successful", wait: 60)
  end
end