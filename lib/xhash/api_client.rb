require 'singleton'

require 'xhash/json_api'

module Xhash
  class ApiClient < JsonApi
    include Singleton

    attr_reader :api_key, :base_url

    def initialize
      @api_key = Xhash.api_key
      @base_url = Xhash.base_url
    end
  end
end
