require_relative '../../base_page.rb'

class DesktopMyAccountPoliciesPage < BasePage

  set_url ('{country}/{language}/my-account/?tab=policies&insuranceType=car')

  element :menu_toggle, :xpath, "(//div[@class='myAccPolicy__daysRemaining']//following-sibling::div)[1]"

  #toggle options
  element :download_policy, :xpath, "(//a[contains(@class, 'myAccPolicy__menu__list__item myAccPolicy__no_policy')])[1]"
  element :cancel_policy, :xpath, "(//a[contains(@href, 'my-account/request-policy-cancellation')])[1]"
  element :emergency_contact, :xpath, "(//a[@data-policy-emergency-info-insurance-type='car'])[1]"
  element :emergency_modal, :css, "[id='modalWrapper']"
  element :roadside_no, :css, "[id='roadsideNo']"
  element :insurer_no, :css, "[id='insurerNo']"
  element :close_modal, :css, "[href='#close-modal']"

  def verify_taken_action_right(scenario)
    case scenario
    when "success login"
      email = $test_data['VALID_EMAIL']
      expect(email_field[:value]).to eq("#{email}")
      expect(page).to have_css("i[class='banking-icon-logout']", :visible => true, :minimum => 1)
    end
  end
end