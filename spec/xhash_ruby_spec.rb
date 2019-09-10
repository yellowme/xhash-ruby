require 'spec_helper'

describe Xhash do
  describe '.config' do
    it 'sets the api key initializer style' do
      Xhash.config { |c| c.api_key = 'abc' }

      expect(Xhash.api_key).to eq('abc')
    end
  end
end
