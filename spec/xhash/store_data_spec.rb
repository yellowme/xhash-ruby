require 'spec_helper'

describe Xhash::General, focus: true do
  describe '.store_data' do
    it 'successfully creates a customer' do
      customer =
        Xhash::General.store_data(
          name: 'pedro',
          last_name: 'can',
          mothers_last_name: 'quintal',
          birth_date: '1997-03-18',
          rfc: 'JIQJ890611FC9',
          curp: 'JIQJ890611HDFXNN04',
          address: 'calle',
          ext_address: 'asdfasdf',
          gender: 'MALE',
          clabe: '032180000118359719',
          activity: '7129019',
          email: 'emilio@xhash.tech',
          phone_number: '9999503059',
          zip_code: '97400',
          external_customer_id: '2443-sadf-23s-fsf'
        )

      expect(customer).to be_a(Xhash::Customer)
      expect(customer.id).to be_truthy
      expect(customer.name).to eq('pedro')
      expect(customer.external_customer_id).to eq('2443-sadf-23s-fsf')
    end
  end
end
