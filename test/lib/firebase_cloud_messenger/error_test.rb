require 'test_helper'

class FirebaseCloudMessenger::ErrorTest < MiniTest::Spec
  describe "::from_respnose" do
    it "returns a BadRequest based on the response status" do
      assert_equal FirebaseCloudMessenger::BadRequest, FirebaseCloudMessenger::Error.from_response(mock_response("400")).class
    end

    it "returns an Unauthroized based on the response status" do
      assert_equal FirebaseCloudMessenger::Unauthorized, FirebaseCloudMessenger::Error.from_response(mock_response("401")).class
    end

    it "returns a Forbidden based on the response status" do
      assert_equal FirebaseCloudMessenger::Forbidden, FirebaseCloudMessenger::Error.from_response(mock_response("403")).class
    end

    it "returns a NotFound based on the response status" do
      assert_equal FirebaseCloudMessenger::NotFound, FirebaseCloudMessenger::Error.from_response(mock_response("404")).class
    end
  end

  describe "#new" do
    it "sets a useful error message" do
      body = { "error" => { "message" => "A useful message" } }.to_json
      assert_includes FirebaseCloudMessenger::Error.new(mock_response("400", body)).message, "A useful message"
    end
  end

  describe "#response_status" do
    it "returns the status code from the response" do
      assert_equal 400, FirebaseCloudMessenger::Error.new(mock_response("400")).response_status
    end
  end

  describe "#response_body" do
    it "returns the raw response body from the response" do
      assert_equal mock_body, FirebaseCloudMessenger::Error.new(mock_response("400", mock_body)).response_body
    end
  end

  describe "#parsed_response" do
    it "returns the raw response body from the response" do
      assert_equal JSON.parse(mock_body), FirebaseCloudMessenger::Error.new(mock_response("400", mock_body)).parsed_response
    end
  end

  describe "#details" do
    it "returns the list of error details from the response" do
      body = { "error" => { "details" => ["behold", "some", "deets"] } }.to_json
      assert_equal ["behold", "some", "deets"], FirebaseCloudMessenger::Error.new(mock_response("400", body)).details
    end
  end

  private

  def mock_response(status, body = mock_body)
    mock_response = mock
    mock_response.expects(:code).at_least_once.returns(status)
    mock_response.expects(:body).at_least_once.returns(body)
    mock_response
  end

  def mock_body
     {"error" => {"details" => "some details"}}.to_json
  end
end
