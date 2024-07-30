require_relative '../../../base_page.rb'

class DesktopFzSendDeclaration < BasePage

  def send_declaration(name)
    click_on(find(:xpath,"//td[text()='#{name}']/following-sibling::td/button"),false)
    visit('https://dcc.testingyalla.xyz/uae/en/quotes')
  end

end
