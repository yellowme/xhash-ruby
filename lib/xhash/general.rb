module Xhash
  class General < ApiClient
    def self.store_data(*user_body)
      url = 'store-data'
      body = Hash[*user_body]
      response = api_post(url: url, body: body)

      unless response[:id]
        raise Xhash::MissingRequiredFieldError.new(
                {
                  message:
                    Xhash::Formatters.invalid_field_message_to_s(response),
                  response: response
                }
              )
      end

      Xhash::Customer.new(*response.values_at(*Xhash::Customer.members))
    end

    def self.get_customer(customer_id:)
      url = "get-customer/#{customer_id}"
      response = api_get(url: url)
      payload = response[:payload]

      if payload.nil?
        raise Xhash::MissingRequiredFieldError.new(
                {
                  message:
                    Xhash::Formatters.invalid_field_message_to_s(response),
                  response: response
                }
              )
      end

      Xhash::Customer.new(*payload.values_at(*Xhash::Customer.members))
    end

    def self.store_file(customer_id:, document_type:, document:)
      url = 'store-file'
      headers = { 'boundary' => '---011000010111000001101001' }
      body = {
        'customer_id' => customer_id,
        'document_type' => document_type,
        'document' => document
      }

      response = api_post_multipart(url: url, body: body, headers: headers)

      unless response == 'Image stored'
        error = JSON.parse(response, symbolize_names: true)
        raise Xhash::MissingRequiredFieldError.new(
                {
                  message: Xhash::Formatters.invalid_field_message_to_s(error),
                  response: error
                }
              )
      end

      response
    end
  end
end
