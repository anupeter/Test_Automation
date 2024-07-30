require_relative '../../../../base_page.rb'

class DesktopBrokerHomeInsurancePolicyDetails < BasePage

  set_url ('{type}/policy/show/{policy_number}')

  element :document_dropdown, :css, "#document"
  element :policy_option, :css, "select[id='document'] option[value='Policy']"
  element :file_input, :css, "[type='file']"
  element :id_back, :xpath, "(//td[text()='ID Back'])/following-sibling::td//span"
  element :policy_status, :xpath, "//*[contains(text(),'Policy Status:')]/strong/span"
  element :remarks_text, :xpath, "(//tr[@id='row--remarks']/td[@colspan='4']/span[@class='detail-span']/textarea[@id='remarks'])[1]"
  element :yes_button, :css, "[id='btnRefund']"

  #Issue policy form
  element :policy_no, :css, "[name='policyNo']"
  element :actual_policy_price, :css, "[name='policyActualPrice']"
  element :credit_note, :css, "[name='creditNote']"
  element :auth_amount, :xpath, "//span[@class='detail-span']//p"
  element :policy_start_date, :css, "[name='actualPolicyStartDate']"
  element :address, :css, "textarea[name='homeAddress']"

  element :issued_button, :css, "[value='Issued']"

  def upload_a_file
    page.execute_script("document.getElementsByName('documentFile')[0].setAttribute('style', 'visible;');")
    page.execute_script("document.getElementsByName('documentFile')[0].style.opacity = 1")
    fields_array = {"Passport" => "pdf", "ID Front" => "jpg",
                    "Emirates ID Back" => "png"}
    fields_array.each_with_object([]) do |(field, type)|
      document_dropdown.click
      find(:css, "select[id='document'] option[value='#{field}']").click
      sleep 1 #TODO: find a workaround to remove sleep
      file_to_upload = File.expand_path(File.dirname(__FILE__) + '/../../../../../../data/' +
                                            "#{field}" + ".#{type}", __dir__)
      file_input.send_keys file_to_upload
      sleep 1
    end
  end

  def upload_policy
    page.execute_script("document.getElementsByName('documentFile')[0].setAttribute('style', 'visible;');")
    page.execute_script("document.getElementsByName('documentFile')[0].style.opacity = 1")
    click_on(document_dropdown, false)
    click_on(find(:css, "select[id='document'] option[value='Policy']"), false)
    sleep 1 #TODO: find a workaround to remove sleep
    file_to_upload = File.expand_path(File.dirname(__FILE__) + '/../../../../../../data/' +
                                          "Policy" + ".pdf", __dir__)
    file_input.send_keys file_to_upload
    sleep 3
  end

  def change_policy_status (status)
    find(:css, "[data-value='#{status}']").click
    remarks_text.send_keys("documents uploaded")
    yes_button.click
    sleep 1 #TODO: find a workaround to remove sleep
  end

  def verify_policy_status (status)
    expect(policy_status).to have_text(status, wait: 20)
  end

  def issue_policy(policy_number, policy_price, note, start_date)
    click_on(issued_button, false)
    policy_no.send_keys(policy_number)
    actual_policy_price.send_keys(policy_price)
    credit_note.send_keys(note)
    policy_start_date.send_keys(start_date)
    address.send_keys("policy address")
    click_on(yes_button, false)
  end
end