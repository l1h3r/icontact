require_relative 'connection'

Dir[File.dirname(__FILE__) + '/api/*'].each do |file|
  require file
end

module IContact
  class Api
    include Connection
    include Accounts
    include ClientFolders
    include Contacts
    include CustomFields
    include Lists
    include Subscriptions
    include Users

    attr_accessor :account_id, :client_folder_id
    attr_reader :app_id, :username, :password

    def initialize(username, password, app_id)
      raise ArgumentError, 'Username cannot be nil' if username.nil?
      raise ArgumentError, 'Password cannot be nil' if password.nil?
      raise ArgumentError, 'App ID cannot be nil' if app_id.nil?

      @app_id     = app_id
      @username   = username
      @password   = password
      @account_id = get_accounts.first['accountId']
      raise IContact::NotAuthorized, 'Unable to find account' if account_id.nil?
      @client_folder_id = get_client_folders.first['clientFolderId']
      raise IContact::NotAuthorized, 'Unable to find client folder' if client_folder_id.nil?
    end

    def ping
      return false if account_id.nil? || client_folder_id.nil?
      url = "#{BASE_URL}/icp/a/#{account_id}/c/#{client_folder_id}/"
      response = connection.run_request(:get, url, '', headers)
      response.status.to_i == 200
    end

    private

    def query(data)
      data.map do |key, value|
        CGI.escape(key.to_s) + '=' + CGI.escape(value.to_s)
      end.sort.join('&').prepend('?')
    end

    def wrap(data)
      return [] if data.nil?
      data.respond_to?(:to_ary) ? data.to_ary : [data]
    end

    def resource(data, collection, first = false)
      if data.empty? || data[collection].nil?
        []
      elsif first
        data[collection].first
      else
        data[collection]
      end
    end

  end
end
