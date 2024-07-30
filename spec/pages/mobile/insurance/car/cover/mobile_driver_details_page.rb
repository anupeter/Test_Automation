require_relative '../../../../base_page.rb'

class MobileCarInsuranceDriverDetails < BasePage

  set_url ('insurance/{country}/{language}/car/driver')

  element :car_year_dropdown, :css, "span[id='select2-year-container']"
  element :year_option, :xpath, "//li[@class='select2-results__option' and text()='2020']"
  element :get_quotes_button, :css, "button[class='button-accent']"

  def choose_option_from_dropdown(nationality, firstLicenseCountry, intExp, localExp, lastClaim, coverPrefence)
    dropdown_fields = {"nationality" => "#{nationality}", "firstLicenseCountry" => "#{firstLicenseCountry}",
                       "internationalExperience" => "#{intExp}", "localExperience" => "#{localExp}",
                       "lastClaimPeriod" => "#{lastClaim}", "coverPrefenceField" => "#{coverPrefence}"} if ENV['COUNTRY'].downcase == 'uae'
    dropdown_fields = {"nationality" => "#{nationality}", "localExperience" => "#{localExp}"} if ENV['COUNTRY'].downcase == 'egy'
    dropdown_fields.each_with_object([]) do |(key, value)|
      click_on(find(:css, "span[id='select2-#{key}-container']"), false)
      sleep 1
      click_on(find(:xpath, "//li[@class='select2-results__option' and text()='#{value}']"), false)
    end
    date = {"policyStartDate_day" => "29", "policyStartDate_month" => "12", "policyStartDate_year" => "2021",
            "dob_day" => "19", "dob_month" => "11", "dob_year" => "1991"}
    date.each_with_object([]) do |(key, value)|
      click_on(find(:css, "select[name='#{key}']"), false)
      click_on(find(:xpath, "//select[@name='#{key}']//option[@value='#{value}']"),false)
    end
  end

  def fill_editbox(name, email, mobile, claimsLastYear)
    editbox_fields = {"name" => "#{name}", "email" => "#{email}", "mobile" => "#{mobile}",
                      "claimsInTheLastYear" => "#{claimsLastYear}"} if ENV['COUNTRY'].downcase == 'uae'
    editbox_fields = {"name" => "#{name}", "email" => "#{email}", "mobile" => "#{mobile}"} if ENV['COUNTRY'].downcase == 'egy'
    editbox_fields.each_with_object([]) do |(key, value)|
      field = find(:css, "input[id='#{key}']")
      field.value.length.times {field.send_keys [:backspace]}
      field.send_keys("#{value}")
    end
  end

  def choose_driver_details(nationality, firstLicenseCountry, intExp, localExp, lastClaim, coverPrefence,name, email, mobile, claimsLastYear)
    choose_option_from_dropdown(nationality, firstLicenseCountry, intExp, localExp, lastClaim, coverPrefence)
    fill_editbox(name, email, mobile, claimsLastYear)
  end
end