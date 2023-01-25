class BasePage < SitePrism::Page
  include RSpec::Matchers
  def scroll_to(element)
    Capybara.current_session.driver.browser.execute_script('arguments[0].scrollIntoView(true);', element.native)
  end

  def scroll_down
    Capybara.current_session.driver.browser.execute_script("return window.scrollBy(0, $(window).height())")
  end

  def wait_for_element(element, count = 100)
    init = 0
    until init == count
      begin
        break if send("has_#{element}?") == true
        sleep 0.3
      rescue
        raise_error(Capybara::ElementNotFound, "Unable to find the element #{element}") if init == count - 1
      end
      init += 1
    end
  end

  def visit_authenticated(url)
    uri = URI.parse(url)
    uri.user = 'staging'
    uri.password = 'Stage9870'
    visit uri
  end

  def javascript_click(element, ajax = false)
    ajax ? wait_for_ajax_calls : false
    page.execute_script("arguments[0].click()", element)
  end

  def click_on(element, eval_option)
    wait_for_ajax
    wait_for_element(element)
    eval(element).click if eval_option == true
    element.click if eval_option == false
  end

  def wait_for_ajax(count = 15)
    init = 0
    until (page.execute_script("return document.readyState").eql?('complete') || init == count)
      sleep 0.3
      init += 1
      raise ArgumentError.new("Assertion not matching") if init == count
    end
  end

  def scroll_to(element)
    Capybara.current_session.driver.browser.execute_script('arguments[0].scrollIntoView(true);', element.native)
  end
end