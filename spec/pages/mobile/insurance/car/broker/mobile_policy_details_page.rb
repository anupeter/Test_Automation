require_relative '../../../../base_page.rb'

class MobileBrokerCarInsurancePolicyDetails < BasePage

  set_url ('{type}/policy/show/{policy_number}')

  element :document_dropdown, :css, "#document"
  element :policy_option, :css, "select[id='document'] option[value='Policy']"
  element :file_input, :css, "[type='file']"
  element :id_back, :xpath, "(//td[text()='Emirates ID Back'])/following-sibling::td//span"
  element :policy_status, :xpath, "//*[contains(text(),'Policy Status:')]/span"
  element :remarks_text, :xpath, "(//tr[@id='row--remarks']/td[@colspan='4']/span[@class='detail-span']/textarea[@id='remarks'])[1]"
  element :yes_button, :xpath, "(//input[@value='Yes'])[1]"

  #issue policy form
  element :policy_no, :css, "[name='policyNo']"
  element :actual_policy_price, :css, "[name='policyActualPrice']"
  element :actual_insured_value, :css, "[name='actualInsuredValue']"
  element :credit_note, :css, "[name='creditNote']"
  element :captured_amount, :css, "[id='capturedAmount']"
  element :auth_amount, :xpath, "//span[@class='detail-span']//p"
  element :policy_start_date, :css, "[id='carQuotePolicyStartDate']"
  element :first_available_day, :xpath, "(//td[@class='available'])[1]"
  element :chassis_no, :css, "[name='chassisNo']"
  element :last_year_provider, :css, "[id='lastYearProvider']"
  element :last_year_provider_option, :css, "option[value='UIC']"
  element :policy_issued_by, :css, "[id='policyIssuanceOwner']"
  element :policy_issued_option, :css, "option[value='YALLACOMPARE']"
  element :issued_button, :css, "[value='Issued']"

  def upload_a_file
    page.execute_script("document.getElementsByName('documentFile')[0].setAttribute('style', 'visible;');")
    page.execute_script("document.getElementsByName('documentFile')[0].style.opacity = 1")
    fields_array = {"Passport" => "pdf", "License" => "jpg", "Vehicle Registration" => "pdf", "ID Front" => "jpg",
                    "Emirates ID Back" => "png", "OFFLINE_QUOTE" => "pdf"}
    fields_array.each_with_object([]) do |(field, type)|
      document_dropdown.click
      find(:css, "select[id='document'] option[value='#{field}']").click
      sleep 1 #TODO: find a workaround to remove sleep
      if ENV['REMOTE'] == 'ON'
        Dir.mkdir("./yc-website/data/") unless Dir.exist?("./yc-website/data/")
        end
      file_to_upload = File.expand_path(File.dirname(__FILE__) + '/../../../../../../data/' +
                                            "#{field}" + ".#{type}", __dir__)
      file_input.send_keys file_to_upload
      sleep 2
    end
    switchery_fields = ["License", "Vehicle Registration", "Emirates ID Front", "Emirates ID Back"]
    switchery_fields.each_with_object([]) do |field|
      find(:xpath, "(//td[text()='#{field}'])[1]/following-sibling::td//span").click
    end
    sleep 3 #TODO: find a workaround to remove sleep
  end

  def upload_policy
    page.execute_script("document.getElementsByName('documentFile')[0].setAttribute('style', 'visible;');")
    page.execute_script("document.getElementsByName('documentFile')[0].style.opacity = 1")
    document_dropdown.click
    find(:css, "select[id='document'] option[value='Policy']").click
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

  def issue_policy(policy_number, policy_price, insured_value, note, chassis_number)
    click_on(issued_button, false)
    policy_no.send_keys(policy_number)
    actual_policy_price.send_keys(policy_price)
    actual_insured_value.send_keys(insured_value)
    credit_note.send_keys(note)
    click_on(policy_start_date, false)
    click_on(first_available_day, false)
    click_on(policy_issued_by, false)
    click_on(policy_issued_option, false)
    chassis_no.send_keys(chassis_number)
    click_on(yes_button, false)
  end
end