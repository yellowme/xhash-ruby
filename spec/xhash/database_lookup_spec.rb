require 'spec_helper'

describe Xhash::SAT do
  describe '.renapo' do
    it 'successfully with valid CURP' do
      curp = 'OESJ980828HDFLNR04'

      stub_request(:post, 'https://xhash.dev/api/database-lookup/renapo')
        .to_return(
        body:
          JSON.dump(
            {
              result: true,
              payload: {
                curp: curp,
                name: 'JERONIMO',
                last_name: 'OLIVA',
                mothers_last_name: 'SANCHEZ',
                gender: 'H',
                province_of_birth: 'DF',
                day_of_birth: '1999-08-28 00:00:00',
                updated_at: '2019-10-03 13:12:32',
                created_at: '2019-10-03 13:12:32',
                id: 76
              }
            }
          ),
        status: 200
      )

      curp_data = Xhash::DatabaseLookup.renapo(curp)

      expect(curp_data).to be_a(Xhash::CURP)
      expect(curp_data.name).to eq('JERONIMO')
      expect(curp_data.last_name).to eq('OLIVA')
      expect(curp_data.mothers_last_name).to eq('SANCHEZ')
      expect(curp_data.day_of_birth).to eq('1999-08-28 00:00:00')
      expect(curp_data.gender).to eq('H')
      expect(curp_data.curp).to eq(curp)
    end

    it 'fails with invalid CURP' do
      curp = 'JIQJ890611HDFXNN04'

      stub_request(:post, 'https://xhash.dev/api/database-lookup/renapo')
        .to_return(
        body:
          JSON.dump(
            {
              result: true,
              payload: {
                id: 65,
                curp: curp,
                name: 'CURP INVALIDO',
                last_name: '',
                mothers_last_name: nil,
                gender: 'H',
                day_of_birth: nil,
                country_of_birth: nil,
                province_of_birth: nil,
                proof_document_payload: nil,
                proof_document_name: nil,
                created_at: '2019-09-02 16:09:07',
                updated_at: '2019-09-02 16:09:07'
              }
            }
          ),
        status: 200
      )

      begin
        Xhash::DatabaseLookup.renapo(curp)
      rescue => exception
        expect(exception).to be_a(Xhash::InvalidFieldError)
        expect(exception.message).to eq(Xhash::ErrorMessage::INVALID_CURP)
      end
    end

    it 'fails with malformed CURP' do
      curp = 'asdf'

      stub_request(:post, 'https://xhash.dev/api/database-lookup/renapo')
        .to_return(
        body: JSON.dump({ result: false, payload: nil }), status: 200
      )

      begin
        Xhash::DatabaseLookup.renapo(curp)
      rescue => exception
        expect(exception).to be_a(Xhash::MissingRequiredFieldError)
        expect(exception.message).to eq(Xhash::ErrorMessage::MISSING_CURP)
      end
    end
  end
end
