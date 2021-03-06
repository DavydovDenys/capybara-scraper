require 'dotenv/load'
require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
require 'byebug'

# Configurations
Capybara.register_driver :selenium do |app|  
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.javascript_driver = :chrome
Capybara.configure do |config|  
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium_chrome_headless
end

browser = Capybara.current_session
driver = browser.driver.browser
