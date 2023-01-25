require 'allure-rspec'
require 'digest'
require 'rspec/retry'


RSpec.configure do |config|
  config.formatter = AllureRspecFormatter
  config.include AllureRspec::AllureRspecModel


  config.before(:each) do |test_case|
    test_case.lifecycle.update_test_case do |container|
      feature_identifier = ENV['FEATURE_IDENTIFIER'] && "#{ENV['FEATURE_IDENTIFIER']}-" || ''
      container.history_id = Digest::MD5.hexdigest(feature_identifier + test_case.id)
      container.labels[6].value = feature_identifier + container.labels[6].value
    end
  end

  # RSpec Retry
  # show retry status in spec process
  config.verbose_retry = true
  # show exception that triggers a retry if verbose_retry is set to true
  config.display_try_failure_messages = true
  # config.clear_lets_on_failure = false
  # run retry only on features
  config.around :each do |ex|
    ex.run_with_retry retry: (ENV['RETRY_COUNT'] || 1).to_i  # 2 means actually 1 retry
  end

  config.after(:example) do |e|
    if e.exception != nil
      Dir.mkdir("./screenshots") unless Dir.exist?("./screenshots")
      # save the file locally
      file_name = page.save_screenshot
      # attaches failed test screenshot to Allure reports
      e.add_attachment(name: e.metadata[:description] + ' (x'  + e.attempts.to_s + ')',
                       source: File.open(file_name ), type: Allure::ContentType::PNG, test_case: true)
    end
    # Stops the browser session between every test case
    #Capybara.current_session.quit
  end

    # Retry capture in allure
  config.retry_callback = proc do |ex|
    def update_test_proc(result, status)
      Allure::ResultUtils.status_details(result.exception).yield_self do |status_detail|
        proc do |test_case|
          test_case.stage = Allure::Stage::FINISHED
          test_case.status = status
          test_case.status_details.message = status_detail.message
          test_case.status_details.trace = status_detail.trace
        end
      end
    end
    Allure.lifecycle.update_test_case(&update_test_proc(ex, :failed))
    Allure.lifecycle.stop_test_case
    Allure.lifecycle.start_test_case(test_result(ex))
  end
end

Allure.configure do |c|
  c.results_directory = "allure-results" # default: gen/allure-results
  c.clean_results_directory = true # clean the output directory first? (default: true)
  c.logging_level = Logger::DEBUG # logging level (default: DEBUG)
end
