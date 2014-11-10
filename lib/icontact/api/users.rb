module IContact
  class Api
    module Users

      def get_user(id)
        response = get(users_path + id)
        resource(response, 'user')
      end

      def get_users(limit = 10000)
        response = get(users_path + query(limit: limit))
        resource(response, 'users')
      end

      def create_user(data)
        response = post(users_path, wrap(data))
        resource(response, 'users', 0)
      end

      def create_users(data)
        response = post(users_path, data)
        resource(response, 'users')
      end

      def update_user(id, data)
        response = post(users_path + id, data)
        resource(response, 'user')
      end

      def update_users(data)
        response = post(users_path, data)
        resource(response, 'users')
      end

      def delete_user(id)
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
