module Xhash
  class OCR < ApiClient
    def self.generic(document_url:)
      url = 'ocr'
      body = { 'document_url' => document_url }

      response = api_post(url, body)
      payload = response[:payload]
      Xhash::Identification.new(
        *payload.values_at(*Xhash::Identification.members)
      )
    end

    def self.ine_reverse(document_url:)
      url = 'ocr/ine-reverse'
      body = { 'document_url' => document_url }

      response = api_post(url, body)
      payload = response[:payload]
      Xhash::Identification.new(
        *payload.values_at(*Xhash::Identification.members)
      )
    end
  end
end
