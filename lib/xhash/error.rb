module Xhash
  class Error < StandardError
    attr_reader :message, :response

    def initialize(options = {})
      if options.is_a? Hash
        @message = options[:message]
        @response = options[:response]
      else
        @message = "Server error"
        @response = options
      end

      super
    end
  end

  class MissingRequiredFieldError < Error; end

  class InvalidFieldError < Error; end

  class MalformedResponse < Error; end
end
