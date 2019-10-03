module Xhash
  class DatabaseLookup < ApiClient
    def self.renapo(curp)
      url = 'database-lookup/renapo'
      body = { curp: curp }
      response = api_post(url: url, body: body)
      payload = response[:payload]
      raise Xhash::MissingRequiredFieldError.new if payload.nil?
      raise Xhash::InvalidCURPError.new if payload[:name] == 'CURP INVALIDO'
      Xhash::CURP.new(*payload.values_at(*Xhash::CURP.members))
    end
  end
end
