require 'singleton'

module Xhash
  class ApiClient
    include Xhash::JsonApi

    def self.config
      yield self
    end

    def self.api_base
      @api_base
    end

    def self.api_base=(api_base)
      @api_base = api_base
    end

    def self.api_key
      @api_key
    end

    def self.api_key=(api_key)
      @api_key = api_key
    end
  end
end
