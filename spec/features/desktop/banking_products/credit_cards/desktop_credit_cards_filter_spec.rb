require_relative '../../../../spec_helper'

feature 'Banking Products- Credit Cards Filter Test Suite', :qat, :uae do
  before do
    set_host ("cover")
    @app.desktop_banking_product.load country: "#{ENV['COUNTRY'].downcase}", language: "#{ENV['LANG'].downcase}"
  end

  scenario 'Verify user can filter credit cards with salary' do
    @app.desktop_banking_product.apply_filter("salary", "10")
    @app.desktop_banking_product.verify_selected_filter("minimum_salary", "10", "integer")
  end

  scenario 'Verify user can filter credit cards with feature' do
    @app.desktop_banking_product.apply_filter("feature", "cash-back")
    @app.desktop_banking_product.verify_selected_filter("product_features_info", "Cash Back", "string")
  end

  scenario 'Verify user can filter credit cards with bank' do
    @app.desktop_banking_product.apply_filter("bank", "hsbc")
    @app.desktop_banking_product.verify_selected_filter("product_name", "HSBC", "string")
  end
end