module FirebaseCloudMessenger
  module AuthClient
    AUTH_SCOPES = ["https://www.googleapis.com/auth/firebase.messaging"].freeze

    def self.fetch_access_token_info
      google_auth_client = Google::Auth.get_application_default(AUTH_SCOPES)
      google_auth_client.fetch_access_token!
    end
  end
end
