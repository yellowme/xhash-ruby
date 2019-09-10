require 'spec_helper'

describe Xhash::OCR do
  let(:ine_reverse_attributes) do
    {
      document_url:
        'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/b3f43a31929437c35b8fb22580119fe389d2e758bad8718387701ee8363caee7.jpg'
    }
  end

  it 'creates successfully ine-reverse' do
    ine_reverse = Xhash::OCR.ine_reverse(ine_reverse_attributes)
    puts ine_reverse
    # expect(ine_reverse).to be_a(Xhash::Document)
  end
end
