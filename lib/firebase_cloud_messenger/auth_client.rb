require 'pathname'

module FirebaseCloudMessenger
  class AuthClient
    attr_reader :credentials_path

    AUTH_SCOPE = "https://www.googleapis.com/auth/firebase.messaging".freeze

    def initialize(credentials_path = nil)
      @credentials_path = credentials_path

      raise_credentials_not_supplied if !credentials_supplied?

      @authorizer = Google::Auth::ServiceAccountCredentials.make_creds(cred_args)
    end

    def fetch_access_token_info
      authorizer.fetch_access_token!
    rescue Faraday::ConnectionFailed
      raise ConnectTimeout
    rescue Faraday::TimeoutError
      raise ReadTimeout
    end

    private

    attr_reader :authorizer

    def credentials_supplied?
      credentials_path || (ENV['GOOGLE_CLIENT_EMAIL'] && ENV['GOOGLE_PRIVATE_KEY'])
    end

    def raise_credentials_not_supplied
      msg = "Either a path to a service account credentials json must be supplied, "\
            "or the `GOOGLE_CLIENT_EMAIL` and `GOOGLE_PRIVATE_KEY` env vars must be set."

      raise ArgumentError, msg
    end

    def cred_args
      args = { scope: AUTH_SCOPE }
      return args unless credentials_path

      file = Pathname.new(credentials_path)
      args.merge(json_key_io: file)
    end
  end
end
