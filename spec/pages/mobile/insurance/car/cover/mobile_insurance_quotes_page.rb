require_relative '../../../../base_page.rb'

class MobileCarInsuranceQuotesDetails < BasePage

  set_url ('insurance/{country}/{language}/car/quotes/{quote_id}')

  #your quotes details form
  element :quote_modal, :css, "[id='vehicle_driver_summary_modal']"
  element :car_field, :xpath, "(//div[@class='col-sm-5 col-md-6'])[1]"
  element :name_field, :xpath, "(//div[@class='col-sm-5 col-md-6'])[2]"
  element :email_field, :xpath, "(//div[@class='col-sm-5 col-md-6'])[3]"
  element :nationality_field, :xpath, "(//div[@class='col-sm-5 col-md-6'])[4]"
  element :int_driving_exp_field, :xpath, "(//div[@class='col-sm-5 col-md-6'])[5]"
  element :regis_date_field, :xpath, "(//div[@class='col-sm-5 col-md-6'])[6]"
  element :gcc_spec, :xpath, "(//div[@class='col-sm-5 col-md-6 '])[2]"

  element :reg_city, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0 '])[1] "
  element :car_value_field, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0'])[1]"
  element :policy_expired_field, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0'])[2]"
  element :mobile_field, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0'])[3]"
  element :dob_field, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0'])[4]"
  element :first_license_country_field, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0'])[5]"
  element :uae_driving_exp_field, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0'])[6]"
  element :last_claim_period_field, :xpath, "(//div[@class='col-sm-5 col-sm-offset-2 col-md-6 col-md-offset-0'])[7]"

  element :all_good_button, :css, "button[class='button-accent px-15 w-auto py-5']"

  #filters
  element :filter_button, :css, "[class='d-md-up-none bg-primary filter_trigger_fixed box-shadow-2 clr-white clr-white']"
  element :agency_repair_filter, :css, "button[data-repairby='maker']"
  element :premium_garage_filter, :css, "button[data-repairby='premiumGarage']"
  element :approved_garage_filter, :css, "button[data-repairby='approvedGarage']"
  element :only_takaful_filter, :css, "span[class='slider round']"
  element :zero_quote_message, :xpath, "//section[@class='no-quotes-section']//div[@class='info-box']"
  element :no_quote_message, :xpath, "//h2[@class='mb-0 mt-0 font-size-1p1rem']"
  element :done_button, :css, "[class='button button-accent line-height-2em']"
  element :insurer_list, :css, "[class='insurance-icon-down-open']"

  #listing
  element :sort_asc, :css, "[data-sort='price:asc coverage:desc']"
  elements :listed_policy, :xpath, "//div[@class='w-100 ']/div[not(@style='display: none;')]"
  elements :listing_policy_feature, :xpath, "//div[contains(@class,'carQuoteV2__product ')]/span[@class='my-5 d-inline-block']/span"
  elements :tpl_policies, :xpath, "//span[@class='my-5 d-inline-block pl-10']//span[@class='srptag defaultTag ml-0']"
  elements :comprehensive_policies, :xpath, "//span[@class='my-5 d-inline-block pl-10']//span[@class='srptag ml-0']"

  #quote details
  elements :buy_now, :xpath, "//div[@class='carQuoteV2__cta']//button[@class='button button-accent']"
  element :price, :xpath, "(//span[@class='price'])[1]"
  element :replacement_car_checkbox, :css, "[class='insurance-label'] + *"

  #blue box filters
  element :comprehensive_agency_repair, :xpath, "//a[@href='#lowest_price_card_v3' and text()='See all Fully Comprehensive + Agency Repair Options']"
  element :comprehensive_not_available, :xpath, "(//div[@class='cheapestQuotes_item'])[2]//button"


  def verify_quotes_details(car, make, modelMaster, model, city, expiredPolicy, nationality, firstLicenseCountry,
                            intExp, localExp, lastClaim, name, email, mobile, claimsLastYear)
    wait_for_element(quote_modal)
    expect(car_field).to have_text("#{car}")
    expect(car_field).to have_text("#{make}")
    expect(car_field).to have_text("#{modelMaster}")
    expect(car_field).to have_text("#{model}")
    expect(reg_city).to have_text("#{city}")
    expect(gcc_spec).to have_text("Yes")
    expect(name_field).to have_text("#{name}")
    expect(email_field).to have_text("#{email}")
    expect(mobile_field).to have_text("#{mobile}")
    expect(nationality_field).to have_text("#{nationality}")
    expect(first_license_country_field).to have_text("#{firstLicenseCountry}")
    expect(int_driving_exp_field).to have_text("#{intExp}")
    expect(uae_driving_exp_field).to have_text("#{localExp}")
    expect(last_claim_period_field).to have_text("#{lastClaim}")
    expect(last_claim_period_field).to have_text("#{claimsLastYear}")
    expect(policy_expired_field).to have_text("#{expiredPolicy}")
  end

  def filter_quotes(filter_type, filter_value)
    click_on(filter_button, false)
    sleep 2
    case filter_type
    when 'Policy Features'
      find(:css, "button[data-type='#{filter_value}']").click
    when 'Insurer'
      scroll_to(insurer_list)
      click_on(insurer_list, false)
      find(:xpath, "//span[@class='max-width-250px' and text()=' #{filter_value}']").click
    when 'Only Takaful'
      scroll_to(only_takaful_filter)
      only_takaful_filter.click
    end
    click_on(done_button, false)
  end

  def verify_filter_applied(filter_type, filter_value)
    wait_for_ajax
    quote_listing = []
    case filter_type
    when 'Policy Features'
      if filter_value == "Third Party Only"
        tpl_policies.size.times do |i|
          quote_listing << tpl_policies[i].text
        end
      else
        comprehensive_policies.size.times do |i|
          quote_listing << comprehensive_policies[i].text
        end
      end
      expect(quote_listing).to include(filter_value) #TODO: check the error for eq
    when 'Insurer'
      listed_policy.size.times do |i|
        quote_listing << (listed_policy[i])['data-provider']
      end
      expect(quote_listing).to include(filter_value) #TODO: check the error for eq
    when 'Only Takaful'
      listed_policy.size.times do |i|
        quote_listing << (listed_policy[i])['data-istakaful']
      end
      expect(quote_listing).to include(filter_value) #TODO: check the error for eq
    end
  end

  def sort_order
    click_on(sort_asc, false)
  end

  def verify_sorting
    price = []
    buy_now.size.times do |i|
      price << ((buy_now)[i]).text.gsub(/[^0-9]/, '').to_i
    end
    expect(price.sort).to eq(price)
  end
end