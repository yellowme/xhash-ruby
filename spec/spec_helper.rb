# require 'webmock/rspec'
require 'rspec'
require 'simplecov'

require 'xhash'

SimpleCov.start { add_filter '/spec/' }

RSpec.configure do |config|
  config.before(:all) do
    Xhash.api_key =
      'api_key'
  end
end
