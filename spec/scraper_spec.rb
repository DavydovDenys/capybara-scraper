require 'capybara/rspec'
require_relative '../scraper'


RSpec.describe Scraper do
  let(:scraper) { Scraper.new }

  describe 'sign in to djinni account' do
    it 'visits the login page and fills in the form' do
      scraper.visit
      scraper.fill_in
      scraper.submit
      expect(scraper.browser.title).to eql('Пропозиції — Джин')
    end
  end

  describe 'list all vacancies' do
    it 'clicks to vacancies link and display all vacancies' do
      scraper.click_link
      expect(scraper.browser).to have_css('h1', text: 'Вакансії на Джині')
    end
  end

  describe 'visit next page' do
    it 'clicks to the next page and gets all vacancies' do
      scraper.browser.click_link('наступна')
      expect(scraper.browser).to have_current_path('https://djinni.co/jobs/?page=2')
    end
  end
end
