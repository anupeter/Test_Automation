require_relative '../../../base_page.rb'

class DesktopFzYopMail < BasePage

  set_url('https://yopmail.com/')
  element :random_generator,:xpath,"//a[text()='Random']"
  element :new_button,:xpath,"//button/span[text()='New']"
  element :email_address,:xpath,"(//div[@id='geny']/span)[1]"
  element :login_field,:xpath,"//input[@id='login']"
  element :declaration_link,:xpath,"//div[@id='mail']/pre"
  element :inbox_button,:xpath,"//button[@title='Check Inbox @yopmail.com']"
  element :mail_button,:xpath,"(//button[@class='lm'])[2]"
  element :link_txt,:xpath,"//div[not(@style) and @id='mail']/pre/text()"
  def generate_email
    random_generator.click
    new_button.click
  end

  def login_yopmail(email)
    login_field.native.clear
    login_field.send_keys(email)
    inbox_button.click
    sleep 1

    within_frame(find(:xpath,"//iframe[@id='ifmail']")) do
      #link_txt= (page.find(:xpath,"//div[not(@style) and @id='mail']/pre")).text
      # result = link_txt.match(/https:(.{66})/)
      page.find(:xpath,"//td/a/span[text()='Go to medical decleration']").click

    end
  end
end
