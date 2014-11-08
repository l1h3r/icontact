require 'faraday'
require 'oj'

require_relative 'connection'
require_relative 'api/client_folders'
require_relative 'api/contacts'
require_relative 'api/custom_fields'
require_relative 'api/lists'
require_relative 'api/subscriptions'
require_relative 'api/users'

module IContact
  class Api
    include Connection
    include ClientFolders
    include Contacts
    include CustomFields
    include Lists
    include Subscriptions
    include Users

    attr_accessor :account_id, :client_id
    attr_reader :app_id, :username, :password, :accounts, :clients

    def initialize(username, password, app_id)
      @app_id     = app_id
      @username   = username
      @password   = password
      @account_id = get_accounts.first['accountId']
      @client_id  = get_clients.first['clientFolderId']
    end

    def get_accounts
      response  = get('/icp/a/')
      @accounts = resource(response, 'accounts')
    end

    def get_clients
      response = get("/icp/a/#{account_id}/c")
      @clients = resource(response, 'clientfolders')
    end

    def ping
      return false if account_id.nil? || client_id.nil?
      url = "#{BASE_URL}/icp/a/#{account_id}/c/#{client_id}/"
      response = connection.run_request(:get, url, '', headers)
      response.status.to_i == 200
    end

    private

    def query(data)
      query = data.map do |key, value|
        CGI.escape(key.to_s) + '=' + CGI.escape(value.to_s)
      end.sort * '&'
      "?#{query}"
    end

    def wrap(data)
      return [] if data.nil?
      data.respond_to?(:to_ary) ? data.to_ary : [data]
    end

    def resource(data, field, position = nil)
      if data.empty? || data[field].nil?
        []
      elsif position.nil?
        data[field]
      else
        data[field][position]
      end
    end

  end
end
