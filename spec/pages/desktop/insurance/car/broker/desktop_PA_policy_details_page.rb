require_relative '../../../../base_page.rb'

class BrokerPAInsurancePolicyDetails < BasePage

  set_url ('pa/list')


  #CAR PA Page
  element :pa_link, :xpath,"//a[contains(text(),'Personal Accident 247 by Salama')]"
  element :pa_provider,:xpath,"//strong[text()='Provider']/parent::td/following-sibling::td[2]/span"
  element :pa_policy_price,:xpath,"//strong[text()='Policy Price']/parent::td/following-sibling::td[2]/span"
  element :pa_vat,:xpath,"//strong[text()='Policy Price VAT']/parent::td/following-sibling::td[2]/span"
  element :pa_total_price,:xpath,"//strong[text()='Total Price']/parent::td/following-sibling::td[2]/span"
  element :pa_payment_plan,:xpath,"//strong[text()='Payment Plan']/parent::td/following-sibling::td[2]/span"
  element :pa_term,:xpath,"//strong[text()='Terms and Rate']/parent::td/following-sibling::td[2]/span"
  element :pa_status,:xpath,"//*[contains(text(),'Policy Status:')]/following-sibling::span"
  element :pa_search_box,:css,"[name='school']"
  element :pa_search_button,:css,"[type='submit']"
  element :cancel_payfort,:css,"[value='Cancel without Payfort']"
  element :cancel_remarks,:xpath,"//tr[@id='row--remarks']/td[@colspan='4']/span[@class='detail-span']/textarea[@id='remarks']"
  element :cancel_yes,:xpath,"//input[@value='Yes']"
  element :current_status,:xpath,"//td[contains(text(),'Current Status')]/following-sibling::td/span"
  element :source_quote, :xpath,"//a[contains(text(),'Source car quote')]"
  element :existing_pa,:xpath,"(//th[text()='PAID']/parent::tr/th)[1]/a"
  #Recurring Payment Modal
  element :recurring_status,:xpath,"//h4[text()='Recurring Payments']/parent::div/following-sibling::div/table//td[1]"
  element :merchant_reference,:xpath,"//h4[text()='Recurring Payments']/parent::div/following-sibling::div/table//td[2]"
  element :recurring_start_date,:xpath,"//h4[text()='Recurring Payments']/parent::div/following-sibling::div/table//td[3]"

  def verify_pa_policy_status (status)
    expect(pa_status).to have_text(status, wait: 20)
  end

  def pa_verification(provider_name,start_date,merchant_ref)
    expect(pa_provider).to have_text("#{provider_name}")
    expect(pa_policy_price).to have_text("0.00")
    expect(pa_vat).to have_text("0.00")
    expect(pa_total_price).to have_text("0.00")
    expect(pa_payment_plan).to have_text("MONTHLY")
    expect(recurring_status).to have_text("Y")
    expect(recurring_start_date).to have_text("#{start_date}")
    expect(merchant_reference).to have_text("#{merchant_ref}")

  end

end