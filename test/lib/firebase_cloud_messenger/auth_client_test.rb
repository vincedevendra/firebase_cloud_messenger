require 'test_helper'

class FirebaseCloudMessenger::AuthClientTest < Minitest::Spec
  describe "::fetch_access_token_info" do
    it "calls out to the Google::Auth service and returns wrapped AccessTokenInfo" do
      google_auth_client = mock('google_auth_client')
      Google::Auth.expects(:get_application_default).with(FirebaseCloudMessenger::AuthClient::AUTH_SCOPES).returns(google_auth_client)

      token_response = { "access_token" => "12345", "token_type" => "Bearer", "expires_in" => "soon" }
      google_auth_client.expects(:fetch_access_token!).returns(token_response)

      access_token_info = FirebaseCloudMessenger::AuthClient.fetch_access_token_info

      assert_equal "12345", access_token_info["access_token"]
    end
  end
end
