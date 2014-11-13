module IContact
  class Api
    module Accounts

      def get_account(id)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = get(accounts_path + id)
        resource(response, 'account')
      end

      def get_accounts
        response  = get(accounts_path)
        resource(response, 'accounts')
      end

      def update_account(id, data)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = post(accounts_path + id, data)
        resource(response, 'account')
      end

      private

      def accounts_path
        '/icp/a/'
      end

    end
  end
end
