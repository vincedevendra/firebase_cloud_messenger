require 'test_helper'

class FirebaseCloudMessenger::ClientTest < MiniTest::Spec
  describe "::new" do
    it "throws an argument error if project_id, credentials_path, env var are not supplied" do
      ENV.stubs(:[]).with('GOOGLE_APPLICATION_CREDENTIALS').returns(nil)

      assert_raises ArgumentError do
        FirebaseCloudMessenger::Client.new
      end
    end

    it "does not throw an argument error if GOOGLE_APPLICATION_CREDENTIALS is set" do
      ENV.stubs(:[]).with('GOOGLE_APPLICATION_CREDENTIALS').returns("path/to/credentials.json")

      FirebaseCloudMessenger::Client.new
    end
  end

  describe "#send" do
    let (:client) do
      client = FirebaseCloudMessenger::Client.new(nil, "2")

      client
    end

    let(:message_to_send) do
      { data: { foo: 1 } }
    end

    let(:mock_401) do
      response = mock('response')
      response.expects(:code).at_least_once.returns("401")
      response
    end

    let(:mock_200) do
      response = mock('response')
      response.expects(:code).at_least_once.returns("200")
      response.expects(:body).at_least_once.returns({"name" => "sample_name"}.to_json)
      response
    end

    it "posts the request with correct arguments" do
      client.access_token = "foo"

      request_body = client.request_body(message_to_send, false)
      request_headers = client.request_headers
      path = client.send_url.path

      conn = mock("request_conn")
      conn.expects(:post).with(path, request_body, request_headers).returns(mock_200)

      client.send(message_to_send, false, conn)
    end

    it "returns a message if the request if successful" do
      client.access_token = "foo"

      conn = mock("request_conn")
      conn.expects(:post).with(any_parameters).returns(mock_200)

      response = client.send(message_to_send, false, conn)
      refute_nil response["name"]
    end

    it "refreshes the access token if the response is '401'" do
      message = { data: { foo: 1 } }

      conn = mock("request_conn")
      conn.expects(:post).twice.with(any_parameters).returns(mock_401).then.returns(mock_200)

      mock_auth_client = mock('auth_client')
      mock_auth_client.expects(:fetch_access_token_info).twice.returns("1")

      FirebaseCloudMessenger::AuthClient.expects(:new).returns(mock_auth_client)

      client.send(message, false, conn)
    end

    it "wraps Net::OpenTimeout exceptions with the custom timeout class" do
      client.access_token = "foo"

      conn = mock("request_conn")
      conn.expects(:post).raises(Net::OpenTimeout)

      assert_raises(FirebaseCloudMessenger::ConnectTimeout) do
        client.send(message_to_send, false, conn)
      end
    end

    it "wraps Net::ReadTimeout exceptions with the custom timeout class" do
      client.access_token = "foo"

      conn = mock("request_conn")
      conn.expects(:post).raises(Net::ReadTimeout)

      assert_raises(FirebaseCloudMessenger::ReadTimeout) do
        client.send(message_to_send, false, conn)
      end
    end
  end

  describe "access token fetching and refreshing" do
    let(:client) { FirebaseCloudMessenger::Client.new(nil, "2") }

    it "calls out to AuthClient again if the token is refreshed" do
      mock_auth_client = mock('auth_client')
      mock_auth_client.expects(:fetch_access_token_info).twice.returns("access_token" => "2").returns("access_token" => "3")

      FirebaseCloudMessenger::AuthClient.expects(:new).returns(mock_auth_client)

      assert_equal "2", client.access_token

      client.refresh_access_token_info
      assert_equal "3", client.access_token
    end
  end

  describe "#project_id" do
    it "reads the project_id from the credentials file if none is supplied to the initializer" do
      ENV.stubs(:[]).with('GOOGLE_APPLICATION_CREDENTIALS').returns("Hello")

      client = FirebaseCloudMessenger::Client.new
      credentials_path = client.credentials_path

      File.expects(:read).with(credentials_path).returns({ project_id: "42" }.to_json)

      assert_equal "42", client.project_id
    end

    it "returns the value passed into the intitializer" do
      client = FirebaseCloudMessenger::Client.new(nil, "2")
      assert_equal "2", client.project_id
    end
  end

  describe "#send_url" do
    let(:client) { FirebaseCloudMessenger::Client.new(nil, "2") }

    it "returns the proper api url" do
      url = client.send_url
      assert_equal "https", url.scheme
      assert_equal "fcm.googleapis.com", url.hostname
      assert_equal "/v1/projects/2/messages:send", url.path
    end
  end

  describe "#request_conn" do
    let(:client) { FirebaseCloudMessenger::Client.new(nil, "2") }

    it "has the correct url" do
      conn = client.request_conn
      assert_equal 443, conn.port
      assert_equal "fcm.googleapis.com", conn.address
    end
  end
end
