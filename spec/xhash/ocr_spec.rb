require 'spec_helper'

describe Xhash::OCR do
  it 'creates successfully ine-reverse' do
    stub_request(:post, Xhash.api_base + 'ocr/ine-reverse').with(
      body:
        '{"document_url":"https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/b3f43a31929437c35b8fb22580119fe389d2e758bad8718387701ee8363caee7.jpg"}',
      headers: {
        'Authorization' => 'api_key', 'Content-Type' => 'application/json'
      }
    )
      .to_return(
      status: 200,
      body:
        '{"result":true,"is_consistentent":false,"payload":{"lines":["IDMEX1836577170<<0747116375842","8007057M1812315MEX<02<<12345<","GOMEZ<VELAZzQUEZ<<MARGARITA<",""],"cic":"183657717","cic_digit_check":"0","is_cic_digit_check_consistent":false,"section_and_consecutive":"0747116375842","date":"800705","date_check_digit":"7","gender":"M","expiration_date":"181231","expiration_date_digit":"5","nationality":"MEX","emission_and_fuar":"02-12345","name":"MARGARITA ","mothers_last_name":"VELAZzQUEZ","last_name":"GOMEZ","last_names":"GOMEZ VELAZzQUEZ"}}',
      headers: {}
    )

    ine_reverse =
      Xhash::OCR.ine_reverse(
        document_url:
          'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/b3f43a31929437c35b8fb22580119fe389d2e758bad8718387701ee8363caee7.jpg'
      )

    expect(ine_reverse).to be_a(Xhash::Document)
  end
end
