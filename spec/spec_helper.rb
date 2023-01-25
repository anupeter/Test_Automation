require 'byebug'
require "net/http"
require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'pages/app'
require 'capybara-screenshot/rspec'
require 'rspec'
require 'rspec/expectations'
require 'rspec/retry'
require 'selenium-webdriver'
require File.dirname(__FILE__) + '//support/retry_allure_helper'

RSpec.configure do |config|
  config.include Capybara::RSpecMatchers
  config.filter_run_when_matching :focus

  Capybara.register_driver :selenium do |app|

    mobile_emulation = {"deviceName" => "Nexus 5"}

    if ENV['REMOTE'] == 'ON'
      url = "http://0.0.0.0:4444/wd/hub"
      capabilities = {
          :browserName => 'chrome',
          'goog:chromeOptions' => {
              args: ['enable-javascript', 'disable-infobars', 'disable-gpu', 'privileged', 'ignore-certificate-errors', 'no-default-browser-check', 'disable-popup-blocking', 'incognito', '--window-size=1600,1268'],
              prefs: {
                  :protocol_handler => {
                      :excluded_schemes => {
                          tel: false,
                      }
                  }
              },
              mobileEmulation: mobile_emulation
          }
      }
      capabilities['goog:chromeOptions'][:mobileEmulation] = {} if ENV['APP'] == 'DESKTOP'
      Capybara::Selenium::Driver.new(app,
                                     browser: :remote,
                                     url: url,
                                     desired_capabilities: capabilities).tap do |driver|
        driver.browser.file_detector = lambda do |args|
          str = args.first.to_s
          str if File.exist?(str)
        end
      end
    else

      capabilities = {
          :browserName => 'chrome',
          'goog:chromeOptions' => {
              args: ['enable-javascript', 'disable-infobars', 'disable-gpu', 'privileged', 'ignore-certificate-errors', 'no-default-browser-check', 'disable-popup-blocking', 'incognito', '--window-size=1600,1268'],
              prefs: {
                  :protocol_handler => {
                      :excluded_schemes => {
                          tel: false,
                      }
                  }
              },
              mobileEmulation: mobile_emulation
          }
      }
      capabilities['goog:chromeOptions'][:mobileEmulation] = {} if ENV['APP'] == 'DESKTOP'
      Capybara::Selenium::Driver.new(
          app,
          :browser => :chrome,
          :desired_capabilities => capabilities,
      )
    end
  end

  Capybara.default_driver = :chrome

  def set_host (host)
    case host
    when 'broker'
      Capybara.app_host = "https://cms.ci4.me/"
    when 'cover'
      if ENV['STAGING_ENV'] == 'ORG'
        Capybara.app_host = "https://staging:Stage9870@testingyalla.xyz"
      elsif ENV['STAGING_ENV'] == 'COVER1'
        Capybara.app_host = "https://staging:Stage9870@stage-cover-1.testingyalla.xyz"
      else
        Capybara.app_host = "https://staging:Stage9870@testingyalla.xyz"
      end
    when 'travel'
      Capybara.app_host = "https://staging:Stage9870@testingyalla.xyz/insurance/uae/en/travel/details"
    when 'pet'
      Capybara.app_host = "https://stage-pet.testingyalla.xyz/uae/en/pet-insurance/pet-details"
    end

  end

  Capybara.configure do |config|
    config.default_max_wait_time = 15 # seconds
    config.default_driver = :selenium
    config.javascript_driver = :selenium
    config.save_path = File.dirname(__FILE__) + "/../screenshots"
  end

  config.before(:all) do
    # Autosave screenshot on failure by capybara
    Capybara::Screenshot.autosave_on_failure = false
    Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
      "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//, '')}"
    end
    Capybara::Screenshot.append_timestamp = true
    dirname = File.dirname(__FILE__) + "/../screenshots"
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  config.before(:example) do |example|
    $test_data = YAML.load_file(File.dirname(__FILE__) + "/../data/test_data.yml")
    @app ||= App.new
  end

  config.after(:example) do |e|
    if e.exception != nil && ENV['REMOTE'] == 'OFF'
      Dir.mkdir("./screenshots") unless Dir.exist?("./screenshots")
      # save the file locally
      file_name = page.save_screenshot
      # attaches failed test screenshot to Allure reports
      e.attach_file(e.metadata[:description] + ' (x' + e.attempts.to_s + ')',
                    File.open(file_name))
    end
    Capybara.current_session.quit
  end

  config.verbose_retry = false
  config.display_try_failure_messages = true
  config.around :each do |ex|
    ex.run_with_retry retry: (ENV['RETRY_COUNT'] || 1).to_i # 2 means actually 1 retry
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.warnings = true
end