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
  end
end
