module Xhash
  class Error < StandardError
    attr_reader :response

    def initialize(response = {})
      @response = response
      super
    end
  end

  class MissingRequiredField < Error; end

  class MissingDocumentURLorFileError < Error; end
end
