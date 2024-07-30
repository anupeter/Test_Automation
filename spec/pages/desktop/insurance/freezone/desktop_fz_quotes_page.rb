require_relative '../../../base_page.rb'

class DesktopFzQuotes < BasePage

  set_url('https://dcc.testingyalla.xyz/uae/en/quotes')

  element :add_member_button,:xpath,"//button[text()='Add Member']"


  def proceed_to_checkout(name)

    page.scroll_to(find(:xpath,"//div[text()='#{name}']"))
    click_on(find(:xpath,"//div[text()='#{name}']/parent::td/following-sibling::td[6]/button"),false)
    sleep 2

  end

  def verify_referral(name)
    page.scroll_to(find(:xpath,"//div[text()='#{name}']"))
    expect(page.find(:xpath,"//div[text()='#{name}']/parent::td/following-sibling::td[5]")).to have_text("REFERRAL  ")
  end

end
