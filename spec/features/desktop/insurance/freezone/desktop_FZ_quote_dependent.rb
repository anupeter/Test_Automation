require_relative '../../../../spec_helper'

feature 'Get Quote for a registered company', :uae do

  scenario 'TC-FZ-002 To get a comprehensive plan for sponsor and dependent' do

    @app.desktop_fz_yop_mail.load
    @app.desktop_fz_yop_mail.generate_email
    email= (@app.desktop_fz_yop_mail.email_address.text) + "@yopmail.com"
    first_name='khal'
    email_text=@app.desktop_fz_yop_mail.email_address.text
    last_name= email_text[1,5]
    name= first_name+' '+last_name

    @app.desktop_fz_login.load
    @app.desktop_fz_login.login("anu.peter+khaladmin@yallacompare.com", "YCBroker@2020")
    page.scroll_to(find(:xpath,"//button/span[text()='Get a Quote']"))
    @app.desktop_fz_employee.get_quote.click
    @app.desktop_fz_employee.employee_form_fill("#{first_name}","#{last_name}","#{email}","0505023025","1988-03-04","Married","Female")
    sleep 1
    @app.desktop_fz_employee.dependent_form("0",last_name,"wife","1988-03-04","Female","Married","Spouse")
    sleep 1
    @app.desktop_fz_employee.done_button.click
    @app.desktop_fz_choose_plan.verify_dependent(name,last_name)
    sleep 1

  end

end
