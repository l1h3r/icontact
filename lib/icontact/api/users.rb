module IContact
  class Api
    module Users

      def get_user(id)
        ensure_valid_id(id)
        response = get(users_path + id)
        resource(response, 'user')
      end

      def get_users(limit = 1000)
        response = get(users_path + query(limit: limit))
        resource(response, 'users')
      end

      def create_user(data)
        response = post(users_path, wrap(data))
        resource(response, 'users', true)
      end

      def create_users(data)
        response = post(users_path, data)
        resource(response, 'users')
      end

      def update_user(id, data)
        ensure_valid_id(id)
        response = post(users_path + id, data)
        resource(response, 'user')
      end

      def update_users(data)
        response = post(users_path, data)
        resource(response, 'users')
      end

      def delete_user(id)
        ensure_valid_id(id)
        response = delete(users_path + id)
        resource(response, 'status')
      end

      private

      def users_path
        "/icp/a/#{account_id}/users/"
      end

    end
  end
end
