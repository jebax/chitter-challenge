ENV['ENVIRONMENT'] = 'test'

require 'capybara'
require 'capybara/rspec'
require 'pg'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require 'sinatra/base'
require 'pry'

require File.join(File.dirname(__FILE__), '../app.rb')
require File.join(File.dirname(__FILE__), './test_helpers.rb')

Capybara.app = Chitter

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end
