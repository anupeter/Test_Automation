require_relative '../../../../base_page.rb'

class DesktopHomeInsuranceThankYou < BasePage

  set_url ('insurance/{country}/{language}/home/checkout/thankyou')

  element :success_message, :css, "h1[class='heading no-margin']"
  element :close_button, :css, "button[type='button']"
  element :upload_documents_button, :css, "a[class='button button-accent']"
  element :reference_number, :xpath, "(//div[@class='thankyou-section']//p)[3]"

  def verify_payment_received
    expect(success_message).to have_text("Hooray!", wait: 60)
  end
end