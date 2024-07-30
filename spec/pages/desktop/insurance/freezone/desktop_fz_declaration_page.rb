  require_relative '../../../base_page.rb'

class DesktopFzDeclaration < BasePage

  #set_url('https://dcc.testingyalla.xyz/uae/en/declaration/eWgUd3m10hjoZu8jGuR1lw==')

  element :next_button,:xpath,"//button[text()='Next']"
  element :confirm_button,:xpath,"//button[text()='Yes']"
  element :start_button,:xpath,"//button[text()='Get Started']"
  element :not_fit_button,:xpath,"//span[text()='False']/ancestor::label"
  element :true_button,:xpath,"//span[text()='True']/ancestor::label"
  element :false_button,:xpath,"//span[text()='False']/ancestor::label"
  element :height_field,:xpath,"//input[@placeholder='Enter height']"
  element :weight_field,:xpath,"//input[@placeholder='Enter weight']"
  element :submit_declaration,:xpath,"//button[text()='Submit Medical Declaration']"
  element :nat_drop_down,:xpath,"//div[@class='ant-select-selector']"
  element :submit_button,:xpath,"//button[text()='Submit']"

  def fill_declaration_form(height,weight)


    next_button.click
    confirm_button.click
    start_button.click
    not_fit_button.click
    i=1
    while i <= 10 do
      true_button.click
      i+=1
    end
    height_field.send_keys(height)
    weight_field.send_keys(weight)
    submit_button.click
    sleep 1
    submit_declaration.click
    sleep 2

  end


  def fill_declaration_form_referral(height,weight)


    next_button.click
    confirm_button.click
    start_button.click
    not_fit_button.click
    false_button.click
    i=1
    while i <= 8 do
      true_button.click
      i+=1
    end


    height_field.send_keys(height)
    weight_field.send_keys(weight)
    submit_button.click
    submit_declaration.click
    sleep 2

  end

end
