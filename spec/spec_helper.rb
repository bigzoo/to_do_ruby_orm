ENV['RACK_ENV'] = 'test'

require('bundler/setup')
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }
Bundler.require(:default, :test)
set(:root, Dir.pwd)

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Task.all.each(&:destroy)
    List.all.each(&:destroy)
  end
end
