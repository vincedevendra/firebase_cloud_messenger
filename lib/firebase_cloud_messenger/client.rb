require 'firebase_cloud_messenger/error'

module FirebaseCloudMessenger
  class Client
    attr_writer :max_retry_count, :project_id, :access_token
    attr_accessor :credentials_path

    def initialize(credentials_path = nil, project_id = nil)
      @credentials_path = credentials_path || ENV['GOOGLE_APPLICATION_CREDENTIALS']
      @project_id = project_id

      if !(@credentials_path || @project_id)
        raise ArgumentError, "Either a project_id or a credentials_path must be supplied"
      end
    end

    def send(message, validate_only, conn)
      retry_count = 0

      loop do
        response = make_fcm_request(message, validate_only, conn || request_conn)

        retry_count += 1
        if response_successful?(response) || retry_count > max_retry_count
          return message_from_response(response)
        elsif response.code == "401"
          refresh_access_token_info
        else
          raise Error.from_response(response)
        end
      end
    end

    def request_conn
      conn = Net::HTTP.new(send_url.host, 443)
      conn.use_ssl = true
      conn
    end

    def request_headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{access_token}"
      }
    end

    def request_body(message, validate_only)
      {
        message: message.to_h,
        validateOnly: validate_only
      }.to_json
    end

    def access_token
      @access_token ||= access_token_info["access_token"]
    end

    def auth_client
      @auth_client ||= AuthClient.new(credentials_path)
    end

    def access_token_info
      @access_token_info ||= auth_client.fetch_access_token_info
    end

    def refresh_access_token_info
      self.access_token = nil
      self.access_token_info = auth_client.fetch_access_token_info
    end

    def project_id
      @project_id ||= JSON.parse(File.read(credentials_path)).fetch("project_id")
    end

    def send_url
      URI "https://fcm.googleapis.com/v1/projects/#{project_id}/messages:send"
    end

    def max_retry_count
      @max_retry_count ||= 1
    end

    private

    attr_writer :access_token_info

    def make_fcm_request(message, validate_only, conn = request_conn)
      conn.post(send_url.path,
                request_body(message, validate_only),
                request_headers)
    rescue Net::OpenTimeout
      raise ConnectTimeout
    rescue Net::ReadTimeout
      raise ReadTimeout
    end

    def message_from_response(response)
      JSON.parse(response.body)
    end

    def response_successful?(response)
      ("200".."299").include?(response.code)
    end
  end
end
