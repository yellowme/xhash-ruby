require 'rspec'
require 'xhash'

RSpec.configure do |config|
  config.before(:all) { Xhash.api_key = 'key_ZLy4aP2szht1HqzkCezDEA' }
end
