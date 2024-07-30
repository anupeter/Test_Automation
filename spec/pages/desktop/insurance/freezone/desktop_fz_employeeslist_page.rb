require_relative '../../../base_page.rb'

class DesktopFzEmployeesList < BasePage

  set_url('https://dcc.testingyalla.xyz/uae/en/employees')

  element :add_employee_button,:xpath,"//button/span[text()='Add Employee']"


end
