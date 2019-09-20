require 'httparty'

module Xhash
  module JsonApi
    module ClassMethods
      def default_headers
        {
          'Content-type' => 'application/json', 'Authorization' => Xhash.api_key
        }
      end

      def api_get(url:, headers: {})
        custom_headers = headers.merge(default_headers)
        response = HTTParty.get(Xhash.api_base + url, headers: custom_headers)

        JSON.parse(response.body, symbolize_names: true)
      end

      def api_post(url:, body: {}, headers: {}, mutipart: false)
        custom_headers = headers.merge(default_headers)

        response =
          HTTParty.post(
            Xhash.api_base + url,
            mutipart: mutipart, body: body.to_json, headers: custom_headers
          )
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
