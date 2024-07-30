require_relative '../../../../spec_helper'

feature 'Get Quote for a registered company', :uae do

  scenario 'TC-FZ-001 To get a comprehensive plan and do individual payment' do

    @app.desktop_fz_yop_mail.load
    @app.desktop_fz_yop_mail.generate_email
    email= (@app.desktop_fz_yop_mail.email_address.text) + "@yopmail.com"
    first_name='brok'
    email_text=@app.desktop_fz_yop_mail.email_address.text
    last_name= email_text[1,5]
    name= first_name+' '+last_name
    emirates_id='784199347739387'


    @app.desktop_fz_login.load
    @app.desktop_fz_login.login("anu.peter+broker_hr@yallacompare.com", "YCBroker@2020")
    sleep 2
    @app.desktop_fz_employees_list.load
    @app.desktop_fz_employees_list.add_employee_button.click
    sleep 1
    @app.desktop_fz_employee.employee_form_fill("#{first_name}","#{last_name}","#{email}","0505023024","1988-03-04","Married","Female")
    sleep 1
    @app.desktop_fz_employee.done_button.click
    #@app.desktop_fz_quotes.load
    #@app.desktop_fz_quotes.add_member_button.click
    @app.desktop_fz_choosemember.choose_member(email)
    sleep 1
    @app.desktop_fz_choose_plan.choose_plan("Premium")
    sleep 1
    @app.desktop_fz_yop_mail.load
    @app.desktop_fz_yop_mail.login_yopmail(email)
    @app.desktop_fz_declaration.fill_declaration_form("162","62")
    @app.desktop_fz_login.load
    @app.desktop_fz_quotes.load
    @app.desktop_fz_quotes.proceed_to_checkout(name)
    sleep 2
    @app.desktop_fz_complete_info.complete_information("#{emirates_id}","#{last_name}","#{last_name}","Albania")
    sleep 2
    @app.desktop_fz_checkout.pay_button.click
    sleep 2
    @app.desktop_fz_payment.payment
    @app.desktop_fz_quotes.load

  end

end


