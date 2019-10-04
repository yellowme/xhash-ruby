module Xhash
  class DatabaseLookup < ApiClient
    def self.renapo(curp)
      url = 'database-lookup/renapo'
      body = { curp: curp }
      response = api_post(url: url, body: body)
      payload = response[:payload]

      if payload.nil?
        raise Xhash::MissingRequiredFieldError.new(
                {
                  message: Xhash::ErrorMessage::MISSING_CURP, response: response
                }
              )
      end

      if payload[:name] == 'CURP INVALIDO'
        raise Xhash::InvalidFieldError.new(
                {
                  message: Xhash::ErrorMessage::INVALID_CURP, response: response
                }
              )
      end

      Xhash::CURP.new(*payload.values_at(*Xhash::CURP.members))
    end
  end
end
