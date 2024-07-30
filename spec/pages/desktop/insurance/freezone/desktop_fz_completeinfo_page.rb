require_relative '../../../base_page.rb'

class DesktopFZCompleteInfo < BasePage

  element :emirates_id_field,:xpath,"//label[@title='Emirates ID']/parent::div/following-sibling::div//input"
  element :passport_field,:xpath,"//label[@title='Passport Number']/parent::div/following-sibling::div//input"
  element :visa_field,:xpath,"//label[@title='Visa File Number']/parent::div/following-sibling::div//input"
  element :nationality_field,:xpath,"//div[@class='ant-select-selector']"
  element :nationality_search,:xpath,"//input[@type='search']"
  element :nationality_selection,:xpath,"//div[@title='India']"
  element :next_button,:xpath,"//button[text()='Next']"

  def complete_information(emirates_id,passport,visa,nationality)

    eid_digits = 15
    eid_digits.times{emirates_id_field.send_keys [:backspace]}
    emirates_id_field.send_keys(emirates_id)
    passport_field.send_keys(passport)
    visa_field.send_keys(visa)
    nationality_field.click
    page.find(:xpath,"//div[@class='rc-virtual-list']")
    page.find(:xpath,"//div[@class='rc-virtual-list-holder-inner']/div[@title='#{nationality}']").click
    sleep 1
    next_button.click

  end

end
