require 'spec_helper'

describe Xhash::SAT do
  describe '.get_rfc' do
    it 'successfully gets rfc by user data' do
      stub_request(:post, 'https://xhash.dev/api/sat/get-rfc').to_return(
        body:
          JSON.dump(
            {
              name: 'Bernardo',
              last_name: 'Suarez',
              mothers_last_name: 'sepulveda',
              birth_date: '1994-03-19',
              rfc: 'SUSB940319BA5'
            }
          ),
        status: 200
      )

      rfc =
        Xhash::SAT.get_rfc(
          name: 'Bernardo',
          last_name: 'Suarez',
          mothers_last_name: 'sepulveda',
          birth_date: '1994-03-19'
        )

      expect(rfc).to be_a(Xhash::RFC)
      expect(rfc.name).to eq('Bernardo')
      expect(rfc.last_name).to eq('Suarez')
      expect(rfc.mothers_last_name).to eq('sepulveda')
      expect(rfc.birth_date).to eq('1994-03-19')
      expect(rfc.rfc).to eq('SUSB940319BA5')
    end
  end
end
