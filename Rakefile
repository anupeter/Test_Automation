require 'rake'
require 'byebug'
require 'rspec/core/rake_task'
require 'json'
require 'uri'
require 'net/http'
require 'rspec/core/rake_task'

task :clean do
  rm_rf "allure-results"
  rm_rf "screenshots"
end

# to run tests in local remote should be set to off, otherwise should be on
task :website_exec, [:country, :project, :environment, :staging_env, :broker_env, :app, :core, :browser, :language, :remote] do |_task, args|
  country = args.country.upcase
  project = args.project.upcase
  environment = args.environment.upcase
  browser = args.browser.upcase
  language = args.language.upcase || 'EN'
  app = args.app.upcase
  core = args.core
  remote = args.remote.upcase
  staging_env = args.staging_env.upcase
  broker_env = args.broker_env.upcase

  ENV['COUNTRY'] = country
  ENV['REMOTE'] = remote
  ENV['ENVIRONMENT'] = environment
  ENV['APP'] = app
  ENV['LANG'] = language
  ENV['RETRY_COUNT'] = 2.to_s # actually means 1 retry
  ENV['ALLURE_RUN'] = 'YES'
  ENV['BROWSER'] = browser
  ENV['STAGING_ENV'] = staging_env
  ENV['BROKER_ENV'] = broker_env
  ENV['FEATURE_IDENTIFIER'] = country # For Allure to identify each run as separate based on given parameter

  rm_rf "screenshots"
  rm_rf "allure-results"
  mkdir_p(["./tmp/#{country}"], verbose: false)

  puts ("<< Country: #{country}, Project: #{project}, Environment: #{environment}, Staging Environment: #{staging_env}, App: #{app} , Core: #{core}, Browser: #{browser} >>, Remote: #{remote}")
  system "parallel_rspec spec/features/#{ENV['APP'].downcase}/" +
             " --runtime-log tmp/#{country}/parallel_runtime_rspec.log" +
             " -o '--tag ~skip_#{country.downcase} --tag #{country.downcase}" +
             " --format progress --format ParallelTests::RSpec::RuntimeLogger --out tmp/parallel_runtime_rspec.log" +
             " -f json -o tmp/#{country}/run$TEST_ENV_NUMBER.json'" +
             " -n #{args.core} > ./tmp/#{country}/process.log"

  if Dir.exist?('allure-results')
    environment_stats = "Platform=#{app}\n"
    "Environment=#{environment}\n" +
        "Browser=#{browser}\n" +
        "Parallel.Core=#{args.core}\n" +
        "Language=#{language}\n"

    File.open('allure-results/environment.properties', 'w') do |f|
      f.write(environment_stats)
    end
  end
end

task :gather_statistics, [:project, :environment, :report_url] do |_task, args|
  args.with_defaults(:report_url => nil)
  project = args.project.capitalize
  environment = args.environment.capitalize
  unless Dir.exist?('tmp')
    puts "Gather Statistics has failed due to /tmp not found"
    next
  end

  mini_report = "Test results for **#{project}** in  **#{environment}**:\\n"
  # Get all files of country runs from /tmp

  country_runs = Dir.glob('tmp/*').select { |f| File.directory? f }
  country_runs.each do |run_folder|
    country = run_folder.split('/')[1].upcase
    stats = {project: args.project.capitalize,
             environment: args.environment.capitalize,
             country: country,
             passed: 0, failed: 0, skipped: 0, undefined: 0}
    files = Dir["#{run_folder}/run*.json"]
    files.each do |run_file|
      file_path = "#{run_file}"
      file = File.read(file_path)
      examples = JSON.parse(file)['examples']

      examples.each do |example|
        status = example['status']
        if status == 'passed'
          stats[:passed] += 1
        elsif status == 'failed'
          stats[:failed] += 1
        elsif %w(skipped pending).include?(status)
          stats[:skipped] += 1
        else
          stats[:undefined] += 1
        end
      end
    end
    mini_report += "`#{country}` - passed: #{stats[:passed]}, failed: #{stats[:failed]}, skipped: #{stats[:skipped]}, undefined: #{stats[:undefined]}\\n"
    # Find the Country name and generate filename
    mkdir_p("tmp/#{country}", verbose: false)
    new_file = "tmp/#{country}/stats.json"

    File.open(new_file, 'w') do |f|
      f.write(stats.to_json)
    end
    puts stats
  end

  mini_report += "[link to Full Report!](#{args.report_url})"
  new_file_text = "tmp/mini_report.txt"
  File.open(new_file_text, 'w') do |f|
    f.write(mini_report)
  end
end

###################################Regression Task

task :website_regression, [:country, :project, :environment, :staging_env, :broker_env, :app, :core, :browser, :language, :remote, :type] do |_task, args|
  country = args.country.upcase
  project = args.project.upcase
  environment = args.environment.upcase
  browser = args.browser.upcase
  language = args.language.upcase || 'EN'
  app = args.app.upcase
  core = args.core
  remote = args.remote.upcase
  staging_env = args.staging_env.upcase
  broker_env = args.broker_env.upcase
  type = args.type.upcase
  ENV['COUNTRY'] = country
  ENV['REMOTE'] = remote
  ENV['ENVIRONMENT'] = environment
  ENV['APP'] = app
  ENV['LANG'] = language
  ENV['RETRY_COUNT'] = 2.to_s # actually means 1 retry
  ENV['ALLURE_RUN'] = 'YES'
  ENV['BROWSER'] = browser
  ENV['STAGING_ENV'] = staging_env
  ENV['BROKER_ENV'] = broker_env
  ENV['FEATURE_IDENTIFIER'] = type # For Allure to identify each run as separate based on given parameter
  ENV['TYPE'] = type
  rm_rf "screenshots"
  rm_rf "allure-results"
  mkdir_p(["./tmp/#{country}"], verbose: false)

  puts ("<< Country: #{country}, Project: #{project}, Environment: #{environment}, Staging Environment: #{staging_env}, Broker Environment: #{broker_env},App: #{app} , Core: #{core}, Browser: #{browser} >>, Remote: #{remote}")
  system "parallel_rspec spec/features/#{ENV['APP'].downcase}/" +
             " --runtime-log tmp/#{country}/parallel_runtime_rspec.log" +
             " -o '--tag ~skip_#{type.downcase} --tag #{type.downcase}" +
             " --format progress --format ParallelTests::RSpec::RuntimeLogger --out tmp/parallel_runtime_rspec.log" +
             " -f json -o tmp/#{country}/run$TEST_ENV_NUMBER.json'" +
             " -n #{args.core} > ./tmp/#{country}/process.log"

  if Dir.exist?('allure-results')
    environment_stats = "Platform=#{app}\n"
    "Environment=#{environment}\n" +
        "Browser=#{browser}\n" +
        "Parallel.Core=#{args.core}\n" +
        "Language=#{language}\n"

    File.open('allure-results/environment.properties', 'w') do |f|
      f.write(environment_stats)
    end
  end
end


