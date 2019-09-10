require 'httparty'

module Xhash
  class JsonApi
    include HTTParty

    protected

    def content_headers
      { 'Content-type' => 'application/json', 'Authorization' => self.api_key }
    end

    def api_get(url, headers = {})
      response = self.class.post(self.base_url + url, body: body.to_json, headers: headers)
      JSON.parse(response.body)
    end

    def api_post(url, body = {}, headers = {})
      response = self.class.post(self.base_url + url, body: body.to_json, headers: headers)
      JSON.parse(response.body)
    end
  end
end
