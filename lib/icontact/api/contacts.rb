module IContact
  class Api
    module Contacts

      def get_contact(id)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = get(contacts_path + id)
        resource(response, 'contact')
      end

      def get_contacts(limit = 10000)
        response = get(contacts_path + query(limit: limit))
        resource(response, 'contacts')
      end

      def create_contact(data)
        response = post(contacts_path, wrap(data))
        resource(response, 'contacts', 0)
      end

      def create_contacts(data)
        response = post(contacts_path, data)
        resource(response, 'contacts')
      end

      def update_contact(id, data)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = post(contacts_path + id, data)
        resource(response, 'contact')
      end

      def update_contact!(id, data)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = put(contacts_path + id, data)
        resource(response, 'contact')
      end

      def update_contacts(data)
        response = post(contacts_path, data)
        resource(response, 'contacts')
      end

      def delete_contact(id)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = delete(contacts_path + id)
        resource(response, 'status')
      end

      def find_contacts(data)
        raise ArgumentError, 'Data cannot be empty' if data.nil? || data.empty?
        data.merge!(limit: 10000) unless data.has_key?(:limit)
        response = get(contacts_path + query(data))
        resource(response, 'contacts')
      end

      private

      def contacts_path
        "/icp/a/#{account_id}/c/#{client_folder_id}/contacts/"
      end

    end
  end
end
