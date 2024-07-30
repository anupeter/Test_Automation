require_relative '../../../../base_page.rb'

class MobileHealthDeclarationDetails < BasePage

  elements :no_declaration_buttons, :xpath, "//label[@class='insurance-label' and text()='No']"
  element :get_button, :css, ".button-accent"

  def choose_option_from_radio
    sleep 2 #TODO: find a workaround to remove sleep
    no_declaration_buttons.size.times do |i|
      click_on(no_declaration_buttons[i], false)
    end
  end
end