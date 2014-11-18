module IContact
  class Api
    module CustomFields

      def get_custom_field(id)
        ensure_valid_id(id)
        response = get(custom_fields_path + id)
        resource(response, 'customfield')
      end

      def get_custom_fields(limit = 10000)
        response = get(custom_fields_path + query(limit: limit))
        resource(response, 'customfields')
      end

      def create_custom_field(data)
        response = post(custom_fields_path, wrap(data))
        resource(response, 'customfields', true)
      end

      def create_custom_fields(data)
        response = post(custom_fields_path, data)
        resource(response, 'customfields')
      end

      def update_custom_field(id, data)
        ensure_valid_id(id)
        response = post(custom_fields_path + id, data)
        resource(response, 'customfield')
      end

      def update_custom_field!(id, data)
        ensure_valid_id(id)
        response = put(custom_fields_path + id, data)
        resource(response, 'customfield')
      end

      def update_custom_fields(data)
        response = post(custom_fields_path, data)
        resource(response, 'customfields')
      end

      def delete_custom_field(id)
        ensure_valid_id(id)
        response = delete(custom_fields_path + id)
        resource(response, 'status')
      end

      private

      def custom_fields_path
        "/icp/a/#{account_id}/c/#{client_folder_id}/customfields/"
      end

    end
  end
end
