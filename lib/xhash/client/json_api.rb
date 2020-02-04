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

        begin
          JSON.parse(response.body, symbolize_names: true)
        rescue => exception
          raise Xhash::MalformedResponse.new
        end
      end

      def api_post(url:, body: {}, headers: {})
        custom_headers = headers.merge(default_headers)

        response =
          HTTParty.post(
            Xhash.api_base + url,
            body: body.to_json, headers: custom_headers
          )

        begin
          JSON.parse(response.body, symbolize_names: true)
        rescue => exception
          raise Xhash::MalformedResponse.new
        end
      end

      def api_post_multipart(url:, body: {}, headers: {})
        custom_headers = headers.merge(default_headers)

        response =
          HTTParty.post(
            Xhash.api_base + url,
            multipart: true, body: body, headers: custom_headers
          )

        response.body
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
