require 'spec_helper'

describe Xhash::OCR do
  describe '.generic' do
    it 'successfully serialize INE to document' do
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

    it 'successfully serialize proof of address to document' do
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
    end
  end

  describe '.identification' do
    it 'successfully serialize INE to document' do
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
  end

  describe '.proof_of_address' do
    it 'successfully serialize proof of address to document' do
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
  end

  describe '.ine_reverse' do
    it 'successfully serialize INE (reverse) to document' do
      ine_reverse =
        Xhash::OCR.ine_reverse(
          document_url:
            'https://kyc-xhash.s3-us-west-2.amazonaws.com/documents/b3f43a31929437c35b8fb22580119fe389d2e758bad8718387701ee8363caee7.jpg'
        )

      expect(ine_reverse).to be_a(Xhash::Identification)
    end
  end
end
