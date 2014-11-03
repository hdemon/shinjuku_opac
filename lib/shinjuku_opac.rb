require "shinjuku_opac/version"
require 'nokogiri'
require 'capybara'
require 'capybara/poltergeist'
require "capybara-webkit"

module ShinjukuOPAC
  BASE_URL = "https://www.library.shinjuku.tokyo.jp/opac/cgi-bin/"

  class Manipulator
    include Capybara::DSL

    def initialize(account)
      @account = account

      Capybara.default_driver = :webkit
      Capybara.default_selector = :xpath

      page.driver.header 'User-Agent', "shinjuku_opac manipulator (zeitdiebe@gmail.com)"
    end

    def login
      visit "http://www.library.shinjuku.tokyo.jp/opac/cgi-bin/userlogin?type=0"
      within(:xpath, "//form[@name='theForm']") do
        fill_in 'n1', with: @account[:user_number]
        fill_in 'n2', with: @account[:password]
      end
      find(:css, ".page_content_frame_control button[type=\"submit\"]").click
    end

    def reserved_list
      login
      click_on "貸出一覧表示"

      document = Nokogiri::HTML.parse(page.html)
      list = document.xpath('//*[@id="page_content"]/div[3]/div[2]/table')
      # テーブル1行目は項目名なので削除する
      list.xpath('//tr[1]').remove
      list.xpath('//tr').map do |item|
        {
          title: item.xpath('td[3]').text,
          return_date: Date.strptime(item.xpath('td[2]').text, "%Y/%m/%d"),
        }
      end
    end
  end
end
