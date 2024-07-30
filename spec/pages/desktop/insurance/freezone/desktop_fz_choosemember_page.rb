require_relative '../../../base_page.rb'

class DesktopFZChooseMember < BasePage

  def choose_member(email)
      click_on(find(:xpath,"//td[text()='#{email}']/following-sibling::td[2]//button"),false)
  end

end
