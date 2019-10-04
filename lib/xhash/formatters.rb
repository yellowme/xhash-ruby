module Xhash
  module Formatters
    def self.invalid_field_message_to_s(hash)
      message = ''
      hash.each { |key, value| message += value[0] + ' ' }
      message.strip
    end
  end
end
