require 'dotenv/load'
require_relative 'configurations'

class Scraper
  attr_reader :browser
  def initialize
    @browser = Capybara.current_session
    @driver = @browser.driver.browser
  end

  def visit
    @browser.visit "https://djinni.co/login?from=frontpage_main"
  end
  
  def fill_in
    @browser.fill_in('Email', with: ENV.fetch('EMAIL'))
    @browser.fill_in('password', with: ENV.fetch('PASSWORD'))
  end
  
  def submit
    @browser.click_on('Увійти')
  end
  
  def click_link
    @browser.click_link('Вакансії')
  end
  
  def get_all_vacancies
    page = 1
    id = 0

    loop do
      # Wait browser to load
      loop do
        sleep(2)
        if @driver.execute_script('return document.readyState') == "complete"
          break
        end
      end

      break if page > 2 # 665 max
      vacancies = @browser.all('li.list-jobs__item')
      vacancies.each do |v|
        puts "Id: #{id += 1}"
        puts "Date:  #{v.find('.pull-right').text.strip}"
        puts "Title: #{v.find('.list-jobs__title').text.strip}"
        puts "Description: #{v.find('.list-jobs__description').text.strip}"
        details = v.find('.list-jobs__details').text.split("\n")
        details.map!{ |el| el.strip }
        puts "Recruter: #{details[1]}"
        options = details[2].split(',')
        puts "Details: #{options}"
        puts
      end
      @browser.click_link('наступна')
      page += 1
    end
  end
end

scraper = Scraper.new
scraper.visit
scraper.fill_in
scraper.submit
scraper.click_link
scraper.get_all_vacancies
