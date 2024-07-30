
require_relative '../../../../spec_helper'

feature 'Get Quote for a registered company', :uae do

  scenario 'TC-FZ-001' do

    @app.desktop_fz_login.load
    @app.desktop_fz_login.login("anu.peter+broker_hr@yallacompare.com", "YCBroker@2020")
    sleep 2
    @app.desktop_fz_quotes.load
    @app.desktop_fz_quotes.proceed_to_checkout("brok euhoi")
    sleep 2
    @app.desktop_fz_complete_info.complete_information("784199347739387","pp/euhoi","101/euhoi","Albania")
    sleep 2

  end
end