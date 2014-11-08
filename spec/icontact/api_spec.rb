require 'spec_helper'

describe IContact::Api do

  describe '#get_accounts' do
    it 'returns all accounts for the user' do
      VCR.use_cassette('get_accounts') do
        accounts = client.get_accounts
        expect(accounts).to be_a(Array)
        expect(accounts).not_to be_empty
      end
    end
  end

  describe '#get_clients' do
    it 'returns all clients for the account' do
      VCR.use_cassette('get_clients') do
        clients = client.get_clients
        expect(clients).to be_a(Array)
        expect(clients).not_to be_empty
      end
    end
  end

  describe '#ping' do
    it 'connects to iContact' do
      VCR.use_cassette('ping') do
        expect(client.ping).to eq(true)
      end
    end
  end

end
