require "shinjuku_opac/version"

require 'nokogiri'
require 'capybara'
require 'capybara/poltergeist'

module ShinjukuOpac
  BASE_URL = "https://www.library.shinjuku.tokyo.jp/opac/cgi-bin/"

  def initialize
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {timeout: 1000})
    end

    Capybara.default_selector = :css
    session = Capybara::Session.new(:poltergeist)
    session.driver.headers = { 'User-Agent' => "shinjuku_opac crawler (zeitdiebe@gmail.com)" }
  end

  def reserved_list
    session.visit "https://www.library.shinjuku.tokyo.jp/opac/cgi-bin/userlendlist"
    page = Nokogiri::HTML.parse(session.html)
  end
end
