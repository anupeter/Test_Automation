require_relative '../../../../base_page.rb'

class DesktopHomeInsuranceDetails < BasePage

  set_url ('insurance/{country}/{language}/home/details')

  element :continue_button, :css, "button[class='button-accent']"
  element :name_field, :css, "input[id='name']"
  element :mobile_field, :css, "input[id='mobile']"
  element :email_field, :css, "input[id='email']"

  def fill_policy_details(name, mobile, mail)
    name_field.send_keys(name)
    mobile_field.send_keys(mobile)
    email_field.send_keys(mail)
  end
end