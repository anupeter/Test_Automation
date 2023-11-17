require_relative '../../../../base_page.rb'

class DesktopBrokerLogin < BasePage

  set_url ('login')

  # set_url ('car/policy/show/{policy_number}')

  element :username_field, :css, "[name='username']"
  element :password_field, :css, "[name='password']"
  element :login_button, :css, "[type='submit']"

  element :product_dropdown, :xpath, "//select[@id='insurance']"


  def login(name, password)
    username_field.send_keys(name)
    password_field.send_keys(password)
    login_button.click
  end

  def select_product(product)
    product_dropdown.click
    click_on(find(:xpath,"//select[@id='insurance']/option[@value='#{product}']"),false)
  end
end