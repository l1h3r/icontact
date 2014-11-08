module IContact
  class Api
    module Contacts

      def get_contact(id)
        response = get(contacts_path + id)
        resource(response, 'contact')
      end

      def get_contacts
        response = get(contacts_path)
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
        response = post(contacts_path + id, data)
        resource(response, 'contact')
      end

      def update_contact!(id, data)
        response = put(contacts_path + id, data)
        resource(response, 'contact')
      end

      def update_contacts(data)
        response = post(contacts_path, data)
        resource(response, 'contacts')
      end

      def delete_contact(id)
        response = delete(contacts_path + id)
        resource(response, 'status')
      end

      def find_contacts(data)
        response = get(contacts_path + query(data))
        resource(response, 'contacts')
      end

      private

      def contacts_path
        "/icp/a/#{account_id}/c/#{client_id}/contacts/"
      end

    end
  end
end
