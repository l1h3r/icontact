module IContact
  module Connection
    BASE_URL = 'https://app.icontact.com'

    DEFAULT_HEADERS = {
      'API-Version' => '2.2',
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    def get(path)
      request(:get, path)
    end

    def post(path, data)
      request(:post, path, data)
    end

    def put(path, data)
      request(:put, path, data)
    end

    def delete(path)
      request(:delete, path)
    end

    private

    def connection
      @connection ||= Faraday.new do |faraday|
        # faraday.response :logger
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

    def headers
      {
        'API-Appid'    => app_id,
        'API-Username' => username,
        'API-Password' => password
      }.merge(DEFAULT_HEADERS)
    end

    def request(method, path, data = {})
      request  = data.empty? ? '' : Oj.dump(data, mode: :compat)
      response = connection.run_request(method, BASE_URL + path, request, headers)
      handle_response(response)
    end

    def handle_response(response)
      case response.status.to_i
      when 200..299
        response_success(response)
      when 404 # Return empty array instead of throwing an error
        []
      else
        IContact::ErrorHandler.new(response)
      end
    end

    def response_success(response)
      if response.env[:method] == :delete
        { 'status' => true }
      elsif response.body.present? && !response.body.strip.empty?
        Oj.load(response.body, mode: :compat)
      else
        []
      end
    end

  end
end
