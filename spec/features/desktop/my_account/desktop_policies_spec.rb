require_relative '../../../spec_helper'

feature 'My Account Test Suite', :uae, :qat do
  scenario 'Verify user can downlaod policy succesfully' do
    set_host ("cover")
    @app.desktop_login.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    auth = DesktopLogin.new
    @app.desktop_login.fill_login_form("#{auth.valid_email}", "#{auth.valid_password}")
    @app.desktop_my_account_detail.policies.click
    @app.desktop_my_account_policies.menu_toggle.click
    @app.desktop_my_account_policies.download_policy.click
    page.driver.browser.navigate.to("chrome://downloads/")
    expect(page).to have_text("Policy")
  end

  scenario 'Verify user can cancel policy' do
    set_host ("cover")
    @app.desktop_login.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    auth = DesktopLogin.new
    @app.desktop_login.fill_login_form("#{auth.valid_email}", "#{auth.valid_password}")
    @app.desktop_my_account_detail.policies.click
    @app.desktop_my_account_policies.menu_toggle.click
    @app.desktop_my_account_policies.cancel_policy.click
    expect(page).to have_text("Request to cancel a policy")
  end

  scenario 'Verify user can see emergency contacts' do
    set_host ("cover")
    @app.desktop_login.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    auth = DesktopLogin.new
    @app.desktop_login.fill_login_form("#{auth.valid_email}", "#{auth.valid_password}")
    @app.desktop_my_account_detail.policies.click
    @app.desktop_my_account_policies.menu_toggle.click
    @app.desktop_my_account_policies.emergency_contact.click
    page.has_css?("[id='roadsideNo']")
    page.has_css?("[id='insurerNo']")
  end

  scenario 'Verify user can close emergency contacts modal' do
    set_host ("cover")
    @app.desktop_login.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    auth = DesktopLogin.new
    @app.desktop_login.fill_login_form("#{auth.valid_email}", "#{auth.valid_password}")
    @app.desktop_my_account_detail.policies.click
    @app.desktop_my_account_policies.menu_toggle.click
    @app.desktop_my_account_policies.emergency_contact.click
    @app.desktop_my_account_policies.close_modal.click
    page.should have_no_selector(:css, "[id='modalWrapper']")
  end

  scenario 'Verify all insurance tabs exist on policies section' do
    set_host ("cover")
    @app.desktop_login.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
    auth = DesktopLogin.new
    @app.desktop_login.fill_login_form("#{auth.valid_email}", "#{auth.valid_password}")
    @app.desktop_my_account_detail.policies.click
    page.should have_selector(:css, "[data-insurance-type='car']")
    page.should have_selector(:css, "[data-insurance-type='health']")
    page.should have_selector(:css, "[data-insurance-type='home']")
    page.should have_selector(:css, "[data-insurance-type='travel']")
  end
end
