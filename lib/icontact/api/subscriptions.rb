module IContact
  class Api
    module Subscriptions

      def get_subscription(id)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = get(subscriptions_path + id)
        resource(response, 'subscription')
      end

      def get_subscriptions(limit = 10000)
        response = get(subscriptions_path + query(limit: limit))
        resource(response, 'subscriptions')
      end

      def create_subscription(data)
        response = post(subscriptions_path, wrap(data))
        resource(response, 'subscriptions', 0)
      end

      def create_subscriptions(data)
        response = post(subscriptions_path, data)
        resource(response, 'subscriptions')
      end

      def update_subscription(id, data)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = post(subscriptions_path + id, data)
        resource(response, 'subscription')
      end

      def move_contact(id, data)
        raise ArgumentError, 'ID cannot be nil' if id.nil?
        response = put(subscriptions_path + id, data)
        resource(response, 'subscription')
      end

      def update_subscriptions(data)
        response = post(subscriptions_path, data)
        resource(response, 'subscriptions')
      end

      private

      def subscriptions_path
        "/icp/a/#{account_id}/c/#{client_folder_id}/subscriptions/"
      end

    end
  end
end
