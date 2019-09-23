require 'spec_helper'

describe Xhash::General do
  describe '.store_data' do
    it 'successfully creates a customer' do
      stub_request(:post, 'https://xhash.dev/api/store-data').to_return(
        body:
          JSON.dump(
            {
              id: 1,
              name: 'pedro',
              last_name: 'can',
              mothers_last_name: 'quintal',
              birth_date: '1997-03-18 00:00:00',
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
              external_customer_id: 'my-customer-id-1'
            }
          ),
        status: 200
      )

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
          external_customer_id: 'my-customer-id-1'
        )

      expect(customer).to be_a(Xhash::Customer)
      expect(customer.id).to be_truthy
      expect(customer.name).to eq('pedro')
      expect(customer.last_name).to eq('can')
      expect(customer.mothers_last_name).to eq('quintal')
      expect(customer.birth_date).to eq('1997-03-18 00:00:00')
      expect(customer.gender).to eq('MALE')
      expect(customer.curp).to eq('JIQJ890611HDFXNN04')
      expect(customer.rfc).to eq('JIQJ890611FC9')
      expect(customer.email).to eq('emilio@xhash.tech')
      expect(customer.external_customer_id).to eq('my-customer-id-1')
    end

    it 'fails to creates a customer by missing data' do
      stub_request(:post, 'https://xhash.dev/api/store-data').to_return(
        body:
          JSON.dump(
            {
              curp: ['The curp field is required.'],
              gender: ['The gender field is required.']
            }
          ),
        status: 200
      )

      begin
        customer =
          Xhash::General.store_data(
            name: 'pedro',
            last_name: 'can',
            mothers_last_name: 'quintal',
            birth_date: '1997-03-18',
            rfc: 'JIQJ890611FC9',
            address: 'calle',
            ext_address: 'asdfasdf',
            clabe: '032180000118359719',
            activity: '7129019',
            email: 'emilio@xhash.tech',
            phone_number: '9999503059',
            zip_code: '97400',
            external_customer_id: 'my-customer-id-1'
          )
      rescue => exception
        expect(exception.response[:curp]).to eq(['The curp field is required.'])
        expect(exception.response[:gender]).to eq(
          ['The gender field is required.']
        )
        expect(exception).to be_a(Xhash::MissingRequiredFieldError)
      end
    end
  end

  describe '.get_customer' do
    it 'successfully fetch customer data' do
      stub_request(:get, 'https://xhash.dev/api/get-customer/my-customer-id-1')
        .to_return(
        body:
          JSON.dump(
            {
              payload: {
                id: 1,
                name: 'pedro',
                last_name: 'can',
                mothers_last_name: 'quintal',
                birth_date: '1997-03-18 00:00:00',
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
                external_customer_id: 'my-customer-id-1'
              }
            }
          ),
        status: 200
      )

      customer = Xhash::General.get_customer(customer_id: 'my-customer-id-1')

      expect(customer).to be_a(Xhash::Customer)
      expect(customer.id).to be_truthy
      expect(customer.name).to eq('pedro')
      expect(customer.external_customer_id).to eq('my-customer-id-1')
    end

    it 'fails to fetch a customer data with bad id' do
      stub_request(:get, 'https://xhash.dev/api/get-customer/my-customer-id-2')
        .to_return(
        body:
          JSON.dump({ customer_id: ['The selected customer id is invalid.'] }),
        status: 200
      )

      begin
        customer = Xhash::General.get_customer(customer_id: 'my-customer-id-2')
      rescue => exception
        expect(exception).to be_a(Xhash::InvalidCustomerFieldError)
        expect(exception.response[:customer_id]).to eq(
          ['The selected customer id is invalid.']
        )
      end
    end
  end

  describe '.store_file' do
    it 'successfully store file to a customer' do
      stub_request(:post, 'https://xhash.dev/api/store-file').to_return(
        body: 'Image stored', status: 200
      )

      document = File.open('spec/files/ife_front.png')

      response =
        Xhash::General.store_file(
          customer_id: 'my-customer-id-1',
          document_type: Xhash::DocumentType::ID::INE_FRONT,
          document: document
        )

      document.close
      expect(response).to eq('Image stored')
    end
  end
end
