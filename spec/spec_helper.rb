# require 'webmock/rspec'
require 'rspec'
require 'simplecov'

require 'xhash'

SimpleCov.start { add_filter '/spec/' }

RSpec.configure { |config| config.before(:all) { Xhash.api_key = 'api_key' } }
