require 'xhash/api_client'

require 'xhash/document'

require 'xhash/ocr'

module Xhash
  @api_base = 'https://xhash.dev/api/'

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
