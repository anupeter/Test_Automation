require_relative '../../../../base_page.rb'

class DesktopCarInsuranceDocumentUpload < BasePage

  set_url ('insurance/uae/en/car/policy/upload-policy-docs/377ad85a1efb24af8ff44b32e08551d1')

  element :emirates_id, :xpath, "(//form[@id='dz_eid_front'])[1]"
  element :driving_license, :xpath, "(//form[@id='dz_eid_front'])[2]"
  element :vehicle_card, :xpath, "(//form[@id='dz_eid_front'])[3]"
  element :upload_eid,  :xpath, '(//input[@name="docType"])[1]'
  element :upload_driving,  :xpath, '(//input[@name="docType"])[2]'
  element :upload_vehicle,  :xpath, '(//input[@name="docType"])[3]'
  element :submit_button, "[class='button-accent']"
end