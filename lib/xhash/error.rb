module Xhash
  class Error < StandardError
    attr_reader :response

    def initialize(response = {})
      @response = response
      super
    end
  end

  class MissingRequiredFieldError < Error; end

  class InvalidCustomerFieldError < Error; end

  class MissingDocumentURLorFileError < Error; end

  class InvalidDocumentError < Error; end

  class InvalidCURPError < Error; end
end
