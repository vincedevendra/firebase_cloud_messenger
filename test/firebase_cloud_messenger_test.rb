require 'test_helper'

class FirebaseCloudMessengerTest < MiniTest::Spec
  describe "::send" do
    it "creates a new instance of client and sends along the args" do
      msg = "Hello I am a message"
      validate_only = false
      conn = "CooooooonnnnN!"

      mock_client = mock('client')
      mock_client.expects(:send).with(msg, validate_only, conn)

      FirebaseCloudMessenger::Client.expects(:new).returns(mock_client)

      FirebaseCloudMessenger.send(message: msg, validate_only: validate_only, conn: conn)
    end
  end

  describe "::validate_message" do
    it "creates a new instance of client and sends along message with validate_only: true" do
      msg = "Hello I am a message"
      conn = "CooooooonnnnN!"

      FirebaseCloudMessenger.expects(:send).with(message: msg, validate_only: true, conn: conn)

      FirebaseCloudMessenger.validate_message(msg, conn)
    end
  end
end
