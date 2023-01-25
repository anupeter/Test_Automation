require_relative '../../../../base_page.rb'

class DesktopCarInsuranceVehicleDetails < BasePage

  set_url ('insurance/{country}/{language}/car/vehicle')

  element :car_year_dropdown, :css, "span[id='select2-year-container']"
  element :model_dropdown, :css, "span[id='select2-model-container']"
  element :year_option, :xpath, "//li[@class='select2-results__option' and text()='2020']"
  element :continue_button, :css, "button[class='button-accent']"
  element :car_value, :css, "input[id='insuredValue']"
  element :deneme, :css, "label[for='isFirstCarTrue']"
  element :option_year, :xpath, "//li[@class='select2-results__option' and text()='2015']"

  def choose_option_from_dropdown(year, make, modelMaster, model, city, carCondition)
    dropdown_fields = {"year" => "#{year}", "make" => "#{make}", "modelMaster" => "#{modelMaster}",
                       "model" => "#{model}", "city" => "#{city}"} if ENV['COUNTRY'].downcase == 'uae'
    dropdown_fields = {"year" => "#{year}", "make" => "#{make}", "modelMaster" => "#{modelMaster}",
                       "model" => "#{model}", "vehicleCondition" => "#{carCondition}"} if ENV['COUNTRY'].downcase == 'egy'
    dropdown_fields.each_with_object([]) do |(key, value)|
      click_on(find(:css, "span[id='select2-#{key}-container']"), false)
      #click_on(find(:xpath, "//li[@class='select2-results__option' and text()='#{value}']"), false)
      click_on(find(:xpath, "//ul[@id='select2-#{key}-results']/li[text()='#{value}']"), false)
      sleep 2 #TODO: find a workaround to remove sleep
    end
  end

  def choose_option_from_radio (firstCar, nonGcc, thirdParty, oldAgency)
    radio_fields = {"FirstCar" => "#{firstCar}", "NonGcc" => "#{nonGcc}", "ThirdParty" => "#{thirdParty}",
                    "OldAgency" => "#{oldAgency}"} if ENV['COUNTRY'].downcase == 'uae'
    radio_fields = {"OldAgency" => "#{oldAgency}",
                    "ExpiredPolicy" => "#{expiredPolicy}"} if ENV['COUNTRY'].downcase == 'egy'
      radio_fields.each_with_object([]) do |(key, value)|
        click_on(find(:css, "label[for='is#{key}#{value}']"), false)
        sleep 1 #TODO: find a workaround to remove sleep
      end
    end

    def fill_editbox
      info = {"insuredValue" => "85000"} if ENV['COUNTRY'].downcase == 'uae'
      info = {"insuredValue" => "85000", "mileage" => "40000"} if ENV['COUNTRY'].downcase == 'egy'
      info.each_with_object([]) do |(key, value)|
        field = find(:css, "input[id='#{key}']")
        field.value.length.times { field.send_keys [:backspace] }
        field.send_keys("#{value}")
      end
    end

    def choose_vehicle_details(year, make, modelMaster, model, city, firstCar, nonGcc, thirdParty, oldAgency, carCondition)
      choose_option_from_dropdown(year, make, modelMaster, model, city, carCondition)
      fill_editbox
      choose_option_from_radio(firstCar, nonGcc, thirdParty, oldAgency)
    end
  def choose_vehicle_details_brand_new(year, make, modelMaster, model, city, carCondition)
    choose_option_from_dropdown(year, make, modelMaster, model, city, carCondition)
    fill_editbox

  end
  end