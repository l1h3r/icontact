require 'spec_helper'

describe IContact::Api do

  before do
    @username = options['username']
    @password = options['password']
    @app_id = options['app_id']
    @client = IContact::Api.new(@username, @password, @app_id)
  end

  describe '#initialize' do
    context 'with valid attributes' do
      it 'sets a username' do
        expect(@client.username).to eq(@username)
      end

      it 'sets a password' do
        expect(@client.password).to eq(@password)
      end

      it 'sets an app id' do
        expect(@client.app_id).to eq(@app_id)
      end
    end

    context 'with invalid attributes' do
      it 'raises an error when username is nil' do
        expect { IContact::Api.new(nil, @password, @app_id) }.to raise_error(ArgumentError)
      end

      it 'raises an error when password is nil' do
        expect { IContact::Api.new(@username, nil, @app_id) }.to raise_error(ArgumentError)
      end

      it 'raises an error when app id is nil' do
        expect { IContact::Api.new(@username, @password, nil) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#ping' do
    context 'with valid account_id and client_folder_id' do
      it 'connects to the icontact api' do
        expect(@client.ping).to eq(true)
      end
    end

    context 'with invalid account_id or client_folder_id' do
      it 'returns false with invalid account_id' do
        @client.account_id = 'hello'
        expect(@client.ping).to eq(false)
      end
      it 'returns false with invalid client_folder_id' do
        @client.client_folder_id = 'tacos'
        expect(@client.ping).to eq(false)
      end
    end
  end

  describe 'attributes' do
    it 'sets a new account id' do
      account_id = @client.get_accounts.sample['accountId']
      @client.account_id = account_id
      expect(@client.account_id).to eq(account_id)
    end

    it 'sets a new client folder id' do
      client_folder_id = @client.get_client_folders.sample['clientFolderId']
      @client.client_folder_id = client_folder_id
      expect(@client.client_folder_id).to eq(client_folder_id)
    end
  end

end
