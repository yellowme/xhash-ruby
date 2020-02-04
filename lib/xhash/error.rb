module Xhash
  class Error < StandardError
    attr_reader :message, :response

    def initialize(options = {})
      @message = options[:message]
      @response = options[:response]
      super
    end
  end

  class MissingRequiredFieldError < Error; end

  class InvalidFieldError < Error; end

  class MalformedResponse < Error; end
end
