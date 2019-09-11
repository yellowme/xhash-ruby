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
    end
  end

  describe '.identification' do
    it 'successfully serialize INE (reverse) to document' do
    end

    it 'successfully serialize INE (anverse) to document' do
    end
  end

  describe '.proof_of_address' do
    it 'successfully serialize proof of address to document' do
    end
  end
end
