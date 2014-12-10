module IContact
  class Api
    module Lists

      def get_list(id)
        ensure_valid_id(id)
        response = get(lists_path + id)
        resource(response, 'list')
      end

      def get_lists(limit = 1000)
        response = get(lists_path + query(limit: limit))
        resource(response, 'lists')
      end

      def create_list(data)
        response = post(lists_path, wrap(data))
        resource(response, 'lists', true)
      end

      def create_lists(data)
        response = post(lists_path, data)
        resource(response, 'lists')
      end

      def update_list(id, data)
        ensure_valid_id(id)
        response = post(lists_path + id, data)
        resource(response, 'list')
      end

      def update_list!(id, data)
        ensure_valid_id(id)
        response = put(lists_path + id, data)
        resource(response, 'list')
      end

      def update_lists(data)
        response = post(lists_path, data)
        resource(response, 'lists')
      end

      def delete_list(id)
        ensure_valid_id(id)
        response = delete(lists_path + id)
        resource(response, 'status')
      end

      private

      def lists_path
        "/icp/a/#{account_id}/c/#{client_folder_id}/lists/"
      end

    end
  end
end
