require 'spec_helper'

describe Xhash::General do
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

  describe '.get_customer' do
    it 'successfully fetch customer data' do
      customer = Xhash::General.get_customer(customer_id: '2443-sadf-23s-fsf')

      expect(customer).to be_a(Xhash::Customer)
      expect(customer.id).to be_truthy
      expect(customer.name).to eq('pedro')
      expect(customer.external_customer_id).to eq('2443-sadf-23s-fsf')
    end
  end

  describe '.store_file' do
    it 'successfully store file to a customer' do
      document = File.open('spec/files/ife_front.png')

      response =
        Xhash::General.store_file(
          customer_id: '2443-sadf-23s-fsf', document_type: 1, document: document
        )

      document.close
      expect(response).to be true
    end
  end
end
