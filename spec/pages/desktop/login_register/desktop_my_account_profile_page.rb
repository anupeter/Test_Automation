require_relative '../../base_page.rb'

class DesktopMyAccountProfile < BasePage

  set_url ('{country}/{language}/my-account/')

  element :email_field, :css, "input[id='email']"
  element :policies, :css, "[href='?tab=policies']"

  def verify_taken_action_right(scenario)
    case scenario
    when "success login"
      email = $test_data['VALID_EMAIL']
      expect(email_field[:value]).to eq("#{email}")
      expect(page).to have_css("i[class='banking-icon-logout']", :visible => true, :minimum => 1)
    end
  end
end