require 'test_helper'

class FirebaseCloudMessenger::AuthClientTest < Minitest::Spec
  describe "::fetch_access_token_info" do
    it "calls out to the Google::Auth service and returns wrapped AccessTokenInfo" do
      credentials_path = "path/to/credentials.json"
      authorizer = mock('authorizer')
      creds_file = mock('creds_file')
      File.expects(:open).with(credentials_path).returns(creds_file)
      creds_file.expects(:close)

      Google::Auth::ServiceAccountCredentials.expects(:make_creds).with(json_key_io: creds_file, scope: FirebaseCloudMessenger::AuthClient::AUTH_SCOPE).returns(authorizer)

      token_response = { "access_token" => "12345", "token_type" => "Bearer", "expires_in" => "soon" }
      authorizer.expects(:fetch_access_token!).returns(token_response)

      access_token_info = FirebaseCloudMessenger::AuthClient.new(credentials_path).fetch_access_token_info

      assert_equal "12345", access_token_info["access_token"]
    end
  end
end
