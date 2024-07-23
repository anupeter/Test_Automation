require_relative '../../../spec_helper'

feature 'Home Page Insurance Navigations', :uae do
  before do
    @app.desktop_home_page.visit_authenticated('https://yallacompare.org/uae/en/')
  end

  scenario 'Verify user can navigate to correct insurance pages from insurance menu' do
    @app.desktop_home_page.verify_each_page_navigation
  end
end