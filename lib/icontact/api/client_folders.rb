module IContact
  class Api
    module ClientFolders

      def get_client_folder(id)
        ensure_valid_id(id)
        response = get(client_folders_path + id)
        resource(response, 'clientfolder')
      end

      def get_client_folders(limit = 10000)
        response = get(client_folders_path + query(limit: limit))
        resource(response, 'clientfolders')
      end

      def create_client_folder(data)
        response = post(client_folders_path, wrap(data))
        resource(response, 'clientfolders', true)
      end

      def create_client_folders(data)
        response = post(client_folders_path, data)
        resource(response, 'clientfolders')
      end

      def update_client_folder(id, data)
        ensure_valid_id(id)
        response = post(client_folders_path + id, data)
        resource(response, 'clientfolder')
      end

      def update_client_folder!(id, data)
        ensure_valid_id(id)
        response = put(client_folders_path + id, data)
        resource(response, 'clientfolder')
      end

      def update_client_folders(data)
        response = post(client_folders_path, data)
        resource(response, 'clientfolders')
      end

      private

      def client_folders_path
        "/icp/a/#{account_id}/c/"
      end

    end
  end
end
