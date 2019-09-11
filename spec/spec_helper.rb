require 'webmock/rspec'
require 'rspec'
require 'xhash'

RSpec.configure { |config| config.before(:all) { Xhash.api_key = 'api_key' } }
