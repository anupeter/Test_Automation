require_relative '../../../../base_page.rb'

class MobileCarLanding < BasePage

  set_url ('insurance/{country}/{language}/car')

  element :cancel_policy_button, :css, "[id='request_cancellation_btn']"
  element :email_field, :css, "[name='email']"
  element :submit_button, :xpath, "//button[@class='btn btn-primary' and text()='Submit']"
  element :email_message, :css, "[style='text-align: center; margin: 1rem auto;']"
  element :warning_message_invalid, :css, "[id='error--invalidEmail']"
  element :warning_message_unknown, :css, "[id='error--unknownEmail']"
  element :warning_message_empty, :css, "[class='field-err-msg']"

  def cancel_policy(email)
    cancel_policy_button.click
    email_field.send_keys(email)
    javascript_click(submit_button)
  end

  def verify_taken_action_right(email)
    case email
    when "valid"
      expect(email_message).to have_text("We have sent a confirmation link to that email address. To go ahead with the cancellation, open the email and select the policy you wish to cancel.", wait:20)
    when "invalid"
      expect(warning_message_invalid).to have_text("Sorry, but that email address does not seem to be valid.")
    when "none_registered"
      expect(warning_message_unknown).to have_text("Sorry, but that email address does not seem to exist in our records.")
    when "empty"
      expect(warning_message_empty).to have_text("Email address is required")
    end
  end
end