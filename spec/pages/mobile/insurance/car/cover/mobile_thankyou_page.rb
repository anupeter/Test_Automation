require_relative '../../../../base_page.rb'

class MobileCarInsuranceThankYou < BasePage

  set_url ('insurance/{country}/{language}/car/checkout/thankyou')

  element :success_message, :css, "h1[class='heading no-margin']"
  element :close_button, :css, "button[type='button']"
  element :upload_documents_button, :css, "a[class='button button-accent']"
  element :reference_number, :xpath, "(//a[@class='button button-accent']/following-sibling::p)[1]"

  def verify_payment_received
    expect(success_message).to have_text("Hooray!", wait: 60)
  end
end