require_relative '../../../base_page.rb'

class DesktopFzChoosePlan < BasePage

  element :send_button,:xpath,"//button[text()='Send now']"

  def choose_plan(plan)
    click_on(find(:xpath,"//h2[text()='#{plan}']/following-sibling::div[2]/button"),false)
    #actual_plan_price= (page.find(:xpath,"//h3[text()='#{plan}']/following-sibling::h4")).text
    send_button.click
    sleep 1
    click_on(find(:xpath,"//a[text()='Go to quotes']"),false )

  end

  def verify_dependent(name,dep_first_name)

    page.scroll_to(find(:xpath,"//td[text()='#{name}']/following-sibling::td[1]/a[@type='button']")).click
    expect(page).to have_xpath("//div[@class='ant-dropdown css-ky2ff3 ant-dropdown-placement-bottomLeft ']/ul/li/span/div[text()='#{dep_first_name}']")


  end

end

