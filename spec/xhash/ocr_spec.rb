require 'spec_helper'

describe Xhash::OCR do
  describe '.generic' do
    it 'successfully serialize INE to document by url' do
      stub_request(:post, 'https://xhash.dev/api/ocr').to_return(
        body:
          JSON.dump(
            {
              payload: {
                name: 'MARGARITA',
                last_name: 'GOMEZ',
                mothers_last_name: 'VELAZQUEZ',
                expiration_date: '2024-12-31',
                street: 'C',
                neighborhood: 'NACIO PITAGORAS 1253',
                zip_code: 'INT 4',
                city: 'COL. MORELOS 04800',
                type: 'INE'
              }
            }
          ),
        status: 200
      )

      ine =
        Xhash::OCR.generic(
          document_url:
            'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/7cd6994d9ad52e8943be1ae00bac60c461430cdf2af6159afa4b9be749706472.png'
        )

      expect(ine).to be_a(Xhash::Identification)
      expect(ine.name).to eq('MARGARITA')
      expect(ine.last_name).to eq('GOMEZ')
      expect(ine.mothers_last_name).to eq('VELAZQUEZ')
      expect(ine.expiration_date).to eq('2024-12-31')
      expect(ine.street).to eq('C')
      expect(ine.neighborhood).to eq('NACIO PITAGORAS 1253')
      expect(ine.zip_code).to eq('INT 4')
      expect(ine.city).to eq('COL. MORELOS 04800')
      expect(ine.type).to eq('INE')
    end

    it 'successfully serialize INE to document by file' do
      stub_request(:post, 'https://xhash.dev/api/ocr').to_return(
        body:
          JSON.dump(
            {
              payload: {
                name: 'MARGARITA',
                last_name: 'GOMEZ',
                mothers_last_name: 'VELAZQUEZ',
                expiration_date: '2024-12-31',
                street: 'C',
                neighborhood: 'NACIO PITAGORAS 1253',
                zip_code: 'INT 4',
                city: 'COL. MORELOS 04800',
                type: 'INE'
              }
            }
          ),
        status: 200
      )

      document = File.open('spec/files/ife_front.png')

      ine = Xhash::OCR.generic(document_file: document)

      document.close

      expect(ine).to be_a(Xhash::Identification)
      expect(ine.name).to eq('MARGARITA')
      expect(ine.last_name).to eq('GOMEZ')
      expect(ine.mothers_last_name).to eq('VELAZQUEZ')
      expect(ine.expiration_date).to eq('2024-12-31')
      expect(ine.street).to eq('C')
      expect(ine.neighborhood).to eq('NACIO PITAGORAS 1253')
      expect(ine.zip_code).to eq('INT 4')
      expect(ine.city).to eq('COL. MORELOS 04800')
      expect(ine.type).to eq('INE')
    end

    it 'successfully serialize proof of address to document by url' do
      stub_request(:post, 'https://xhash.dev/api/ocr').to_return(
        body:
          JSON.dump(
            {
              payload: {
                full_name: 'Prof Francesco Reichert',
                neighborhood: 'Parkerchester',
                full_address:
                  'CLL 59 E DIAGONAL 623\n76 Y 74 A Y RED CANALIZA\nLAS AMERICAS\nMERIDA, MERIDA YU\nC.P. 97302-CR -97111',
                zip_code: '97302',
                province: 'Port Rosemarieview,VT',
                date: '2019-09-01',
                type: 'TELMEX'
              }
            }
          ),
        status: 200
      )

      proof_of_address =
        Xhash::OCR.generic(
          document_url:
            'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/c7d40899ab9ed7aa689837e39b64a6eb07117353f88ce3f8b9d1ca73bea3d80e.png'
        )

      expect(proof_of_address).to be_a(Xhash::ProofOfAddress)
      expect(proof_of_address.full_name).to eq('Prof Francesco Reichert')
      expect(proof_of_address.neighborhood).to eq('Parkerchester')
      expect(proof_of_address.province).to eq('Port Rosemarieview,VT')
      expect(proof_of_address.type).to eq('TELMEX')
      expect(proof_of_address.date).to eq('2019-09-01')
      expect(proof_of_address.zip_code).to eq('97302')
      expect(proof_of_address.full_address).to eq(
        'CLL 59 E DIAGONAL 623\n76 Y 74 A Y RED CANALIZA\nLAS AMERICAS\nMERIDA, MERIDA YU\nC.P. 97302-CR -97111'
      )
    end

    it 'successfully serialize proof of address to document by file' do
      stub_request(:post, 'https://xhash.dev/api/ocr').to_return(
        body:
          JSON.dump(
            {
              payload: {
                full_name: 'Prof Francesco Reichert',
                neighborhood: 'Parkerchester',
                province: 'Port Rosemarieview,VT',
                type: 'TELMEX'
              }
            }
          ),
        status: 200
      )

      document = File.open('spec/files/telmex.png')

      proof_of_address = Xhash::OCR.generic(document_file: document)

      document.close

      expect(proof_of_address).to be_a(Xhash::ProofOfAddress)
      expect(proof_of_address.full_name).to eq('Prof Francesco Reichert')
      expect(proof_of_address.neighborhood).to eq('Parkerchester')
      expect(proof_of_address.province).to eq('Port Rosemarieview,VT')
      expect(proof_of_address.type).to eq('TELMEX')
    end

    it 'fails to serialize INE to document with html error' do
      stub_request(:post, 'https://xhash.dev/api/ocr').to_return(
        body: '<p>error</p>',
        status: 200,
        headers: { 'Content-Type' => 'text/html; charset=UTF-8' }
      )

      begin
        ine =
          Xhash::OCR.generic(
            document_url:
              'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/7cd6994d9ad52e8943be1ae00bac60c461430cdf2af6159afa4b9be749706472.png'
          )
      rescue => exception
        expect(exception).to be_a(Xhash::MalformedResponse)
      end
    end

    it 'fails with missing file or url' do
      begin
        ine = Xhash::OCR.generic
      rescue => exception
        expect(exception).to be_a(Xhash::MissingRequiredFieldError)
        expect(exception.message).to eq(Xhash::ErrorMessage::MISSING_FILE)
      end
    end
  end

  describe '.identification' do
    it 'successfully serialize INE to document' do
      stub_request(:post, 'https://xhash.dev/api/ocr/identification').to_return(
        body:
          JSON.dump(
            {
              payload: {
                name: 'MARGARITA',
                last_name: 'GOMEZ',
                mothers_last_name: 'VELAZQUEZ',
                expiration_date: '2024-12-31',
                street: 'C',
                neighborhood: 'NACIO PITAGORAS 1253',
                zip_code: 'INT 4',
                city: 'COL. MORELOS 04800',
                type: 'INE'
              }
            }
          ),
        status: 200
      )

      ine_anverse =
        Xhash::OCR.identification(
          document_url:
            'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/7cd6994d9ad52e8943be1ae00bac60c461430cdf2af6159afa4b9be749706472.png'
        )

      expect(ine_anverse).to be_a(Xhash::Identification)
      expect(ine_anverse.name).to eq('MARGARITA')
      expect(ine_anverse.last_name).to eq('GOMEZ')
      expect(ine_anverse.mothers_last_name).to eq('VELAZQUEZ')
      expect(ine_anverse.expiration_date).to eq('2024-12-31')
      expect(ine_anverse.street).to eq('C')
      expect(ine_anverse.neighborhood).to eq('NACIO PITAGORAS 1253')
      expect(ine_anverse.zip_code).to eq('INT 4')
      expect(ine_anverse.city).to eq('COL. MORELOS 04800')
      expect(ine_anverse.type).to eq('INE')
    end

    it 'fails with missing file or url' do
      begin
        ine = Xhash::OCR.identification
      rescue => exception
        expect(exception).to be_a(Xhash::MissingRequiredFieldError)
      end
    end

    it 'fails with invalid INE document' do
      stub_request(:post, 'https://xhash.dev/api/ocr').to_return(
        body: JSON.dump({ result: false, payload: nil }), status: 200
      )

      begin
        ine =
          Xhash::OCR.generic(
            document_url:
              'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/7cd6994d9ad52e8943be1ae00bac60c461430cdf2af6159afa4b9be749706472.png'
          )
      rescue => exception
        expect(exception).to be_a(Xhash::InvalidFieldError)
      end
    end
  end

  describe '.proof_of_address' do
    it 'successfully serialize proof of address to document' do
      stub_request(:post, 'https://xhash.dev/api/ocr/proof-of-address')
        .to_return(
        body:
          JSON.dump(
            {
              payload: {
                full_name: 'Prof Francesco Reichert',
                neighborhood: 'Parkerchester',
                province: 'Port Rosemarieview,VT',
                type: 'TELMEX'
              }
            }
          ),
        status: 200
      )

      proof_of_address =
        Xhash::OCR.proof_of_address(
          document_url:
            'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/c7d40899ab9ed7aa689837e39b64a6eb07117353f88ce3f8b9d1ca73bea3d80e.png'
        )

      expect(proof_of_address).to be_a(Xhash::ProofOfAddress)
      expect(proof_of_address.full_name).to eq('Prof Francesco Reichert')
      expect(proof_of_address.neighborhood).to eq('Parkerchester')
      expect(proof_of_address.province).to eq('Port Rosemarieview,VT')
      expect(proof_of_address.type).to eq('TELMEX')
    end

    it 'fails with missing file or url' do
      begin
        proof_of_address = Xhash::OCR.proof_of_address
      rescue => exception
        expect(exception).to be_a(Xhash::MissingRequiredFieldError)
      end
    end

    it 'fails with invalid proof of address document' do
      stub_request(:post, 'https://xhash.dev/api/ocr/proof-of-address')
        .to_return(
        body: JSON.dump({ result: false, payload: nil }), status: 200
      )

      begin
        ine =
          Xhash::OCR.proof_of_address(
            document_url:
              'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/7cd6994d9ad52e8943be1ae00bac60c461430cdf2af6159afa4b9be749706472.png'
          )
      rescue => exception
        expect(exception).to be_a(Xhash::InvalidFieldError)
      end
    end
  end

  describe '.ine_reverse' do
    it 'successfully serialize INE (reverse) to document' do
      stub_request(:post, 'https://xhash.dev/api/ocr/ine-reverse').to_return(
        body:
          JSON.dump(
            {
              is_consistentent: false,
              payload: {
                lines: [
                  'IDMEX1836577170<<0747116375842',
                  '8007057M1812315MEX<02<<12345<7',
                  'GOMEZ<VELAZzQUEZ<<MARGARITA<',
                  ''
                ],
                cic: '183657717',
                cic_digit_check: '0',
                is_cic_digit_check_consistent: false,
                section_and_consecutive: '0747116375842',
                date: '800705',
                date_check_digit: '7',
                gender: 'M',
                expiration_date: '181231',
                expiration_date_digit: '5',
                nationality: 'MEX',
                emission_and_fuar: '02-12345',
                name: 'MARGARITA ',
                mothers_last_name: 'VELAZzQUEZ',
                last_name: 'GOMEZ',
                last_names: 'GOMEZ VELAZzQUEZ'
              }
            }
          ),
        status: 200
      )

      ine_reverse =
        Xhash::OCR.ine_reverse(
          document_url:
            'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/b3f43a31929437c35b8fb22580119fe389d2e758bad8718387701ee8363caee7.jpg'
        )

      expect(ine_reverse).to be_a(Xhash::Identification)
    end

    it 'fails with missing file or url' do
      begin
        ine_reverse = Xhash::OCR.ine_reverse
      rescue => exception
        expect(exception).to be_a(Xhash::MissingRequiredFieldError)
      end
    end

    it 'fails with invalid INE reverse document' do
      stub_request(:post, 'https://xhash.dev/api/ocr/ine-reverse').to_return(
        body: JSON.dump({ result: false, payload: nil }), status: 200
      )

      begin
        ine =
          Xhash::OCR.ine_reverse(
            document_url:
              'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/7cd6994d9ad52e8943be1ae00bac60c461430cdf2af6159afa4b9be749706472.png'
          )
      rescue => exception
        expect(exception).to be_a(Xhash::InvalidFieldError)
      end
    end
  end
end
