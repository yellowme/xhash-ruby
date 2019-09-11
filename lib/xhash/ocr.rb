module Xhash
  class OCR < ApiClient
    IDENTIFICATION_TYPES = %w[INE]

    def self.generic(document_url:)
      url = 'ocr'
      body = { 'document_url' => document_url }

      response = api_post(url, body)
      payload = response[:payload]

      is_identification = IDENTIFICATION_TYPES.include? payload[:type]

      document =
        if is_identification
          Xhash::Identification.new(
            *payload.values_at(*Xhash::Identification.members)
          )
        else
          Xhash::ProofOfAddress.new(
            *payload.values_at(*Xhash::ProofOfAddress.members)
          )
        end

      document
    end

    def self.identification(document_url:)
      url = 'ocr/identification'
      body = { 'document_url' => document_url }

      response = api_post(url, body)
      payload = response[:payload]

      Xhash::Identification.new(
        *payload.values_at(*Xhash::Identification.members)
      )
    end

    def self.proof_of_address(document_url:)
      url = 'ocr/proof-of-address'
      body = { 'document_url' => document_url }

      response = api_post(url, body)
      payload = response[:payload]

      Xhash::ProofOfAddress.new(
        *payload.values_at(*Xhash::ProofOfAddress.members)
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
