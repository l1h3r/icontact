require 'spec_helper'

describe IContact::Api::Contacts do

  let(:contact_id) { '9316234' }

  describe '#get_contact' do
    it 'returns a single contact' do
      VCR.use_cassette('get_contact') do
        contact = client.get_contact(contact_id)
        expect(contact).to be_a(Hash)
        expect(contact).not_to be_empty
        expect(contact['contactId']).to eq(contact_id)
      end
    end
  end

  describe '#get_contacts' do
    it 'returns all contacts' do
      VCR.use_cassette('get_contacts') do
        contacts = client.get_contacts
        expect(contacts).to be_a(Array)
        expect(contacts).not_to be_empty
      end
    end
  end

  describe '#create_contact' do
    it 'creates and returns a new contact' do
      VCR.use_cassette('create_contact') do
        data = {
          firstName: Faker::Name.first_name,
          lastName: Faker::Name.last_name,
          email: Faker::Internet.email
        }
        contact = client.create_contact(data)
        expect(contact).to be_a(Hash)
        expect(contact).not_to be_empty
        expect(contact['contactId']).not_to be_nil
      end
    end
  end

  describe '#create_contacts' do
    it 'creats a returns a collection of new contacts' do
      VCR.use_cassette('create_contacts') do
        data = [{
          firstName: Faker::Name.first_name,
          lastName: Faker::Name.last_name,
          email: Faker::Internet.email
        },{
          firstName: Faker::Name.first_name,
          lastName: Faker::Name.last_name,
          email: Faker::Internet.email
        }]
        contacts = client.create_contacts(data)
        expect(contacts).to be_a(Array)
        expect(contacts).not_to be_empty
        expect(contacts.count).to eq(2)
      end
    end
  end

  describe '#find_contacts' do
    context 'when searching by first name' do
      it 'returns all contacts that match the given params' do
        VCR.use_cassette('find_contacts_first_name') do
          contacts = client.find_contacts(firstName: 'Charlie')
          expect(contacts).to be_a(Array)
          expect(contacts).not_to be_empty
          expect(contacts.first['firstName']).to eq('Charlie')
        end
      end
    end

    context 'when searching by last name' do
      it 'returns all contacts that match the given params' do
        VCR.use_cassette('find_contacts_last_name') do
          contacts = client.find_contacts(lastName: 'Br*')
          expect(contacts).to be_a(Array)
          expect(contacts).not_to be_empty
          expect(contacts.first['lastName']).to start_with('Br')
        end
      end
    end
  end

end
