module IContact
  class Api
    module Accounts

      def get_account(id)
        ensure_valid_id(id)
        response = get(accounts_path + id)
        resource(response, 'account')
      end

      def get_accounts
        response  = get(accounts_path)
        resource(response, 'accounts')
      end

      def update_account(id, data)
        ensure_valid_id(id)
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
