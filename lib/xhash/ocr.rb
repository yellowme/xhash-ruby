module Xhash
  class OCR < ApiClient
    IDENTIFICATION_TYPES = ['INE', 'CARTILLA MILITAR', 'PASAPORTE']

    def self.generic(document_url: nil, document_file: nil)
      url = 'ocr'

      if document_url.nil? and document_file.nil?
        raise Xhash::MissingRequiredFieldError.new(
                { message: Xhash::ErrorMessage::MISSING_FILE }
              )
      end

      payload =
        request_by_file_or_url(
          url: url, document_url: document_url, document_file: document_file
        )

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

    def self.identification(document_url: nil, document_file: nil)
      url = 'ocr/identification'

      if document_url.nil? and document_file.nil?
        raise Xhash::MissingRequiredFieldError.new(
                { message: Xhash::ErrorMessage::MISSING_FILE }
              )
      end

      payload =
        request_by_file_or_url(
          url: url, document_url: document_url, document_file: document_file
        )

      Xhash::Identification.new(
        *payload.values_at(*Xhash::Identification.members)
      )
    end

    def self.proof_of_address(document_url: nil, document_file: nil)
      url = 'ocr/proof-of-address'

      if document_url.nil? and document_file.nil?
        raise Xhash::MissingRequiredFieldError.new(
                { message: Xhash::ErrorMessage::MISSING_FILE }
              )
      end

      payload =
        request_by_file_or_url(
          url: url, document_url: document_url, document_file: document_file
        )

      Xhash::ProofOfAddress.new(
        *payload.values_at(*Xhash::ProofOfAddress.members)
      )
    end

    def self.ine_reverse(document_url: nil, document_file: nil)
      url = 'ocr/ine-reverse'

      if document_url.nil? and document_file.nil?
        raise Xhash::MissingRequiredFieldError.new(
                { message: Xhash::ErrorMessage::MISSING_FILE }
              )
      end

      payload =
        request_by_file_or_url(
          url: url, document_url: document_url, document_file: document_file
        )

      Xhash::Identification.new(
        *payload.values_at(*Xhash::Identification.members)
      )
    end

    private

    def self.request_by_file_or_url(
      url: nil, document_url: nil, document_file: nil
    )
      body = {
        'document_url' => document_url, 'document_file' => document_file
      }

      response =
        if document_file.nil?
          api_post(
            url: url,
            body: body,
            headers: { 'boundary' => '---011000010111000001101001' }
          )
        else
          data = api_post_multipart(url: url, body: body)
          JSON.parse(data, symbolize_names: true)
        end

      payload = response[:payload]

      if payload.nil?
        raise Xhash::InvalidFieldError.new(
                { message: Xhash::ErrorMessage::INVALID_FILE }
              )
      end

      payload
    end
  end
end
