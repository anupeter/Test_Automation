require_relative '../../../base_page.rb'

class DesktopFzEmployee < BasePage

  element :get_quote,:css,"[type='submit']"
  element :first_name,:css,"[id='firstName']"
  element :last_name,:css,"[id='lastName']"
  element :email_field,:css,"[id='email']"
  element :mobile_field,:css,"[id='phone']"
  element :dob_field,:css,"[id='dob']"
  element :marital_status_field,:xpath,"//span[@title='Single']"
  element :marital_status_select,:xpath,"//div[@class='rc-virtual-list-holder-inner']/div[@title='Married']"
  element :gender_field,:xpath,"(//div[@class='ant-select ant-select-lg ant-select-in-form-item css-ky2ff3 ant-select-single ant-select-show-arrow'])[1]"
  element :done_button,:xpath,"//button/span[text()='Done']"
  element :add_dependent,:xpath,"//button/span[2][text()='Add Dependent']"

  def employee_form_fill(firstName,lastName,email,mobile,dob,marital_status,gender)

    first_name.send_keys(firstName)
    last_name.send_keys(lastName)
    email_field.send_keys(email)
    mobile_field.send_keys(mobile)
    dob_field.send_keys(dob)
    click_on(find(:xpath,"//td[@class='ant-picker-cell ant-picker-cell-in-view ant-picker-cell-selected']"),false)
    marital_status_field.click
    click_on(find(:xpath,"//div[@class='rc-virtual-list-holder-inner']/div[@title='#{marital_status}']"),false)
    gender_field.click
    click_on(find(:xpath,"//div[@class='ant-select-item-option-content' and text()='#{gender}']"),false)


  end

  def dependent_form(dependent_id,firstName,lastName,dob,gender,marital_status,relationship)

    add_dependent.click
    page.find(:css,"[id='dependents_#{dependent_id}_firstName']").send_keys(firstName)
    page.find(:css,"[id='dependents_#{dependent_id}_lastName']").send_keys(lastName)
    page.find(:css,"[id='dependents_#{dependent_id}_dob']").send_keys(dob)
    click_on(find(:xpath,"//td[@class='ant-picker-cell ant-picker-cell-in-view ant-picker-cell-selected']"),false)
    page.find(:xpath,'//input[@id="dependents_0_maritalStatus"]',visible:false).click
    page.find(:xpath,"//div[@id='dependents_#{dependent_id}_maritalStatus_list']/following-sibling::div//div//div/div/div[@title='#{marital_status}']").click
    page.find(:xpath,'//input[@id="dependents_0_gender"]',visible:false).click
    page.find(:xpath,"//div[@id='dependents_#{dependent_id}_gender_list']/following-sibling::div//div//div/div/div[@title='#{gender}']").click
    page.find(:xpath,'//input[@id="dependents_0_relationship"]',visible:false).click
    page.find(:xpath,"//div[@id='dependents_#{dependent_id}_relationship_list']/following-sibling::div//div//div/div/div[@title='#{relationship}']").click

  end

end
