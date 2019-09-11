module Xhash
  class General < ApiClient
    def self.store_data(*user_body)
      url = 'store-data'
      body = Hash[*user_body]

      response = api_post(url, body)

      Xhash::Customer.new(
        *response.values_at(*Xhash::Customer.members)
      )
    end

    def self.get_customer(customer_id:)
      url = "get-customer/#{customer_id}"

      response = api_get(url)
      payload = response[:payload]

      Xhash::Customer.new(
        *payload.values_at(*Xhash::Customer.members)
      )
    end
  end
end
