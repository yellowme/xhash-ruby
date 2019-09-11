require 'httparty'

module Xhash
  module JsonApi
    module ClassMethods
      def default_headers
        {
          'Content-type' => 'application/json', 'Authorization' => Xhash.api_key
        }
      end

      def api_get(url, custom_headers = {})
        headers = custom_headers.merge(default_headers)
        response =
          HTTParty.get(
            Xhash.api_base + url,
            body: body.to_json, headers: headers
          )
        JSON.parse(response.body)
      end

      def api_post(url, body = {}, custom_headers = {})
        headers = custom_headers.merge(default_headers)
        response =
          HTTParty.post(
            Xhash.api_base + url,
            body: body.to_json, headers: headers
          )
        JSON.parse(response.body)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
