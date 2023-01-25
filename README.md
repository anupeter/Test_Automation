$## YallaCompare Automation

### Tools, Frameworks and Techniques Used
- Ruby
- Capybara
- Rspec
- PageObjectPattern
- Html report 
- Screenshots in case of failure

### Environment Setup
* Install Ruby and Ruby Mine 

* To install bundler: 
`gem install bundler`

* Project dependencies:
`bundle install`

### Running Tests
* Run tests for UAE in local from your IDE terminal
```
$ rake website_exec[uae,website,production,desktop,chrome,en,off]
```
* Run tests for Qatar in local from your IDE terminal
```
$ rake website_exec[qat,website,production,desktop,firefox,en,off]
```
* Run tests for both countries(UAE and Qatar) in local from your IDE terminal
```
$ bash path/to/file/test_runner.sh
```
* To clean all logs
```
$ rake clean
```

### Allure Setup and Prepare
* After each test run, json will be located in `allure-results` folder

* To install allure in local:
```
$ brew install allure
```

* To open html report in browser
```
$ allure serve
```
<img width="1679" alt="Screen Shot 2020-05-27 at 10 27 13 AM" src="https://user-images.githubusercontent.com/33934833/82985272-c85be380-a004-11ea-87fa-f28c3266f1ce.png">

<img width="1679" alt="Screen Shot 2020-05-27 at 10 27 48 AM" src="https://user-images.githubusercontent.com/33934833/82985315-df023a80-a004-11ea-9f8d-52f73be5fe4c.png">

### Browser Selection
* Browser configuration was done for Chrome and Firefox currently, more browser can be added to configuration in spec_helper.rb.
* Chrome was selected in test_runner.sh by default if you wish to change it to firefox, you just need to change test_runner.sh
* Screen resolution was set to standard 13" to 15" (1600 x 1400) in spec_helper.rb, if you wish to change windows size please change those infos
* And make sure you have browser drivers in your directory:  `/usr/local/bin/`

### Screenshots 
* In case of failure; screenshots folder will be created and screenshots will be located in: `yallacompare/screenshots`