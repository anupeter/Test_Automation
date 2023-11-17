current_path = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift File.join(current_path)

Dir.glob(File.join(current_path, '**', '*.rb')).each do |f|
  require f
end

class App
  def initialize
    @pages = {}
  end

  def desktop_home_page
    @pages[:desktop_home_page] ||= DesktopHomePage.new
  end

  def desktop_register
    @pages[:desktop_register] ||= DesktopRegister.new
  end

  def desktop_login
    @pages[:desktop_login] ||= DesktopLogin.new
  end

  def desktop_my_account_detail
    @pages[:desktop_my_account_detail] ||= DesktopMyAccountProfile.new
  end

  def desktop_my_account_policies
    @pages[:desktop_my_account_policies] ||= DesktopMyAccountPoliciesPage.new
  end

  def desktop_banking_product
    @pages[:desktop_banking_product] ||= DesktopBankingProduct.new
  end

  def desktop_car_insurance_vehicle_details
    @pages[:desktop_car_insurance_vehicle_details] ||= DesktopCarInsuranceVehicleDetails.new
  end

  def desktop_car_insurance_driver_details
    @pages[:desktop_car_insurance_driver_details] ||= DesktopCarInsuranceDriverDetails.new
  end

  def desktop_pre_quotes_page
    @pages[:desktop_pre_quotes_page] ||= DesktopPreQuotesPage.new
  end

  def desktop_car_insurance_quotes_details
    @pages[:desktop_car_insurance_quotes_details] ||= DesktopCarInsuranceQuotesDetails.new
  end

  def desktop_car_insurance_checkout
    @pages[:desktop_car_insurance_checkout] ||= DesktopCarInsuranceCheckout.new
  end

  def desktop_car_insurance_payment
    @pages[:desktop_car_insurance_payment] ||= DesktopCarInsurancePayment.new
  end

  def desktop_car_insurance_thank_you
    @pages[:desktop_car_insurance_thank_you] ||= DesktopCarInsuranceThankYou.new
  end

  def desktop_car_insurance_document_upload
    @pages[:desktop_car_insurance_document_upload] ||= DesktopCarInsuranceDocumentUpload.new
  end

  def desktop_car_landing
    @pages[:desktop_car_landing] ||= DesktopCarLanding.new
  end

  def desktop_health_landing
    @pages[:desktop_health_landing] ||= DesktopHealthLanding.new
  end

  def desktop_health_insurance_details
    @pages[:desktop_health_insurance_details] ||= DesktopHealthInsuranceDetails.new
  end

  def desktop_health_declaration_details
    @pages[:desktop_health_declaration_details] ||= DesktopHealthDeclarationDetails.new
  end

  def desktop_health_quote_list
    @pages[:desktop_health_quote_list] ||= DesktopHealthQuoteList.new
  end

  def desktop_health_insurance_checkout
    @pages[:desktop_health_insurance_checkout] ||= DesktopHealthInsuranceCheckout.new
  end

  def desktop_health_insurance_payment
    @pages[:desktop_health_insurance_payment] ||= DesktopHealthInsurancePayment.new
  end

  def desktop_health_insurance_thank_you
    @pages[:desktop_health_insurance_thank_you] ||= DesktopHealthInsuranceThankYou.new
  end

  def desktop_home_landing
    @pages[:desktop_home_landing] ||= DesktopHomeLanding.new
  end

  def desktop_home_insurance_details
    @pages[:desktop_home_insurance_details] ||= DesktopHomeInsuranceDetails.new
  end

  def desktop_home_quote_list
    @pages[:desktop_home_quote_list] ||= DesktopHomeQuoteList.new
  end

  def desktop_home_insurance_checkout
    @pages[:desktop_home_insurance_checkout] ||= DesktopHomeInsuranceCheckout.new
  end

  def desktop_home_insurance_payment
    @pages[:desktop_home_insurance_payment] ||= DesktopHomeInsurancePayment.new
  end

  def desktop_home_insurance_thank_you
    @pages[:desktop_home_insurance_thank_you] ||= DesktopHomeInsuranceThankYou.new
  end

  def desktop_travel_landing
    @pages[:desktop_travel_landing] ||= DesktopTravelLanding.new
  end

  def desktop_travel_quote_list
    @pages[:desktop_travel_quote_list] ||= DesktopTravelQuoteList.new
    end

  def desktop_travel_insurance_checkout
    @pages[:desktop_travel_insurance_checkout] ||= DesktopTravelInsuranceCheckout.new
  end

  def desktop_travel_insurance_payment
    @pages[:desktop_travel_insurance_payment] ||= DesktopTravelInsurancePayment.new
  end

  def desktop_travel_insurance_thank_you
    @pages[:desktop_travel_insurance_thank_you] ||= DesktopTravelInsuranceThankYou.new
  end

  def desktop_life_insurance_landing
    @pages[:desktop_life_insurance_landing] ||=DesktopLifeInsuranceLanding.new
  end

  def desktop_life_insurance_details
    @pages[:desktop_life_insurance_details] ||=DesktopLifeInsuranceDetails.new
  end

  def desktop_life_insurance_quote_list
    @pages[:desktop_life_insurance_quote_list] ||= DesktopLifeInsuranceQuoteList.new
  end

  def desktop_life_insurance_checkout
    @pages[:desktop_life_insurance_checkout] ||= DesktopLifeInsuranceCheckout.new
  end

  def desktop_life_insurance_payment
    @pages[:desktop_life_insurance_payment] ||= DesktopLifeInsurancePayment.new
  end

  def desktop_life_insurance_thank_you
    @pages[:desktop_life_insurance_thank_you] ||= DesktopLifeInsuranceThankYou.new
  end

  def pet_user_journey
    @pages[:pet_user_journey] ||= PetUserJourney.new
  end

  #BROKER
  def desktop_broker_login
    @pages[:desktop_broker_login] ||= DesktopBrokerLogin.new
  end

  def mobile_broker_login
    @pages[:mobile_broker_login] ||= MobileBrokerLogin.new
  end

  def broker_car_insurance_policy_details
    @pages[:broker_car_insurance_policy_details] ||=BrokerCarInsurancePolicyDetails.new
  end

  def mobile_broker_car_insurance_policy_details
    @pages[:mobile_broker_car_insurance_policy_details] ||=MobileBrokerCarInsurancePolicyDetails.new
  end

  def broker_pa_insurance_policy_details
    @pages[:broker_pa_insurance_policy_details] ||=BrokerPAInsurancePolicyDetails.new
  end


  def broker_health_insurance_policy_details
    @pages[:broker_health_insurance_policy_details] ||= BrokerHealthInsurancePolicyDetails.new
  end

  def mobile_broker_health_insurance_policy_details
    @pages[:mobile_broker_health_insurance_policy_details] ||= MobileBrokerHealthInsurancePolicyDetails.new
  end

  def desktop_broker_home_insurance_policy_details
    @pages[:desktop_broker_home_insurance_policy_details] ||= DesktopBrokerHomeInsurancePolicyDetails.new
  end

  def broker_travel_insurance_policy_details
    @pages[:broker_travel_insurance_policy_details] ||=BrokerTravelInsurancePolicyDetails.new
  end

  def desktop_fz_login
    @pages[:desktop_fz_login] ||= DesktopFzLogin.new
  end

  def desktop_fz_employee
    @pages[:desktop_fz_employee] ||= DesktopFzEmployee.new
  end

  def desktop_fz_choose_plan
    @pages[:desktop_fz_choose_plan]||= DesktopFzChoosePlan.new
  end

  def desktop_fz_send_declaration
    @pages[:desktop_fz_send_declaration] ||= DesktopFzSendDeclaration.new
  end

  def desktop_fz_yop_mail
    @pages[:desktop_fz_yop_mail] ||= DesktopFzYopMail.new
  end

  def desktop_fz_declaration
    @pages[:desktop_fz_declaration] ||= DesktopFzDeclaration.new
  end

  def desktop_fz_quotes
    @pages[:desktop_fz_quotes] ||= DesktopFzQuotes.new
  end

  def desktop_fz_checkout
    @pages[:desktop_fz_checkout] ||= DesktopFzCheckout.new
  end

  def desktop_fz_payment
    @pages[:desktop_fz_payment] ||= DesktopFzPayment.new
  end

  def desktop_fz_employees_list
    @pages[:desktop_fz_employees_list] ||= DesktopFzEmployeesList.new
  end

  def desktop_fz_choosemember
    @pages[:desktop_fz_choosemember] ||= DesktopFZChooseMember.new
  end

  def desktop_fz_complete_info
    @pages[:desktop_fz_complete_info] ||= DesktopFZCompleteInfo.new
  end

  ##MOBILE##
  def mobile_car_landing
    @pages[:mobile_car_landing] ||= MobileCarLanding.new
  end

  def mobile_car_insurance_quotes_details
    @pages[:mobile_car_insurance_quotes_details] ||= MobileCarInsuranceQuotesDetails.new
  end

  def mobile_car_insurance_vehicle_details
    @pages[:mobile_car_insurance_vehicle_details] ||= MobileCarInsuranceVehicleDetails.new
  end

  def mobile_car_insurance_driver_details
    @pages[:mobile_car_insurance_driver_details] ||= MobileCarInsuranceDriverDetails.new
  end

  def mobile_car_insurance_checkout
    @pages[:mobile_car_insurance_checkout] ||= MobileCarInsuranceCheckout.new
  end

  def mobile_car_insurance_payment
    @pages[:mobile_car_insurance_payment] ||= MobileCarInsurancePayment.new
  end

  def mobile_car_insurance_thank_you
    @pages[:mobile_car_insurance_thank_you] ||= MobileCarInsuranceThankYou.new
  end

  def mobile_car_insurance_document_upload
    @pages[:mobile_car_insurance_document_upload] ||= MobileCarInsuranceDocumentUpload.new
  end

  def mobile_health_landing
    @pages[:mobile_health_landing] ||= MobileHealthLanding.new
  end

  def mobile_health_insurance_details
    @pages[:mobile_health_insurance_details] ||= MobileHealthInsuranceDetails.new
  end

  def mobile_health_declaration_details
    @pages[:mobile_health_declaration_details] ||= MobileHealthDeclarationDetails.new
  end

  def mobile_health_quote_list
    @pages[:mobile_health_quote_list] ||= MobileHealthQuoteList.new
  end

  def mobile_health_insurance_checkout
    @pages[:mobile_health_insurance_checkout] ||= MobileHealthInsuranceCheckout.new
  end

  def mobile_health_insurance_payment
    @pages[:mobile_health_insurance_payment] ||= MobileHealthInsurancePayment.new
  end

  def mobile_health_insurance_thank_you
    @pages[:mobile_health_insurance_thank_you] ||= MobileHealthInsuranceThankYou.new
  end
end