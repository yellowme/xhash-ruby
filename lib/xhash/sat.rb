module Xhash
  class SAT < ApiClient
    def self.get_rfc(name: nil, last_name: nil, mothers_last_name: nil, birth_date: nil)
      url = 'sat/get-rfc'
      body = {name: name, last_name: last_name, mothers_last_name: mothers_last_name, birth_date: birth_date}
      response = api_post(url: url, body: body)
      raise Xhash::MissingRequiredFieldError.new(response) unless response[:rfc]
      Xhash::RFC.new(*response.values_at(*Xhash::RFC.members))
    end
  end
end
