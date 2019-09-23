require 'json'

require 'xhash/client/json_api'
require 'xhash/client/api_client'

require 'xhash/error'
require 'xhash/structs/rfc'
require 'xhash/structs/identification'
require 'xhash/structs/proof_of_address'
require 'xhash/structs/customer'

require 'xhash/sat'
require 'xhash/general'
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
