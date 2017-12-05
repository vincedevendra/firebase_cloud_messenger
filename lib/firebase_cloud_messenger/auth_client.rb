module FirebaseCloudMessenger
  class AuthClient
    attr_reader :credentials_path

    AUTH_SCOPE = "https://www.googleapis.com/auth/firebase.messaging".freeze

    def initialize(credentials_path)
      @credentials_path = credentials_path
      @authorizer = get_authorizer
    end

    def fetch_access_token_info
      @authorizer.fetch_access_token!
    end

    private

    def get_authorizer
      begin
        file = File.open(credentials_path)
        Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: file, scope: AUTH_SCOPE)
      ensure
        file.close
      end
    end
  end
end
