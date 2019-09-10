module Xhash
  class OCR < ApiClient
    def self.ine_reverse(document_url:)
      url = 'ocr/ine-reverse'
      body = { 'document_url' => document_url }

      self.api_post(url, body)
    end
  end
end
