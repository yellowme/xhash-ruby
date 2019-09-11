module Xhash
  class OCR < ApiClient
    def self.ine_reverse(document_url:)
      url = 'ocr/ine-reverse'
      body = { 'document_url' => document_url }

      response = api_post(url, body)
      Xhash::Document.new(response['payload'])
    end
  end
end
