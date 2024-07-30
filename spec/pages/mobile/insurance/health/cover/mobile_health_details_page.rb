require_relative '../../../../base_page.rb'

class MobileHealthInsuranceDetails < BasePage

  set_url ('insurance/{country}/{language}/health/details')

  element :one_more_step_button, :css, "button[class='button-accent']"
  element :year_dropdown, :css, "[class='ui-datepicker-year']"
  element :calendar_dropdown, :css, "[placeholder='yyyy-mm-dd']"


  def choose_option_from_dropdown(nationality, gender, cityId, relationship, option)
    if option == ("Your family" || "Your maid / driver")
      dropdown_fields = {"nationality" => "#{nationality}", "gender" => "#{gender}",
                         "cityId" => "#{cityId}", "relationship" => "#{relationship}"}
    else
      dropdown_fields = {"nationality" => "#{nationality}", "gender" => "#{gender}",
                         "cityId" => "#{cityId}"}
    end
    dropdown_fields.each_with_object([]) do |(key, value)|
      click_on(find(:css, "span[id='select2-members0#{key}-container']"), false) if key != 'cityId'
      click_on(find(:css, "span[id='select2-#{key}-container']"), false) if key == 'cityId'
      click_on(find(:xpath, "//li[@class='select2-results__option' and text()='#{value}']"), false)
    end
  end

  def fill_editbox(name, email, mobile)
    editbox_fields = {"name" => "#{name}", "email" => "#{email}", "phone" => "#{mobile}"}
    editbox_fields.each_with_object([]) do |(key, value)|
      field = find(:css, "input[id='#{key}']")
      field.value.length.times { field.send_keys [:backspace] }
      field.send_keys("#{value}")
    end
  end

  def choose_option_from_radio (insuranceFor, salaryOver4k, option)
    if option == ("Your family" || "Your maid / driver")
      radio_fields = {"insuranceForYourself" => "#{insuranceFor}", "salaryOver4k" => "#{salaryOver4k}"}
    else
      radio_fields = {"salaryOver4k" => "#{salaryOver4k}"}
    end
    radio_fields.each_with_object([]) do |(key, value)|
      click_on(find(:css, "label[for='#{key}#{value}']"), false)
      sleep 2 #TODO: find a workaround to remove sleep
    end
  end

  def choose_dob(year, month, day)
    calendar_dropdown.click
    dob_fields = {"year" => "#{year}", "month" => "#{month}"}
    dob_fields.each_with_object([]) do |(key, option)|
      click_on(find(:css, "[class='ui-datepicker-#{key}']"), false)
      click_on(find(:xpath, "//*[@class='ui-datepicker-#{key}']/option[@value='#{option}']"), false)
    end
    click_on(find(:xpath, "//a[@class='ui-state-default' and text()='#{day}']"), false)
  end

  def choose_member_details(nationality, gender, cityId, name, email, mobile, relationship, insuranceFor, salaryOver4k,
                            year, month, day, option)
    choose_option_from_dropdown(nationality, gender, cityId, relationship, option)
    choose_option_from_radio(insuranceFor, salaryOver4k, option)
    fill_editbox(name, email, mobile)
    choose_dob(year, month, day)
  end
end