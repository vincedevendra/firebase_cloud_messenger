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
    describe "with a hash message" do
      it "creates a message and checks it for validity" do
        hash_message = { token: "token" }
        mock_message = mock('message')
        mock_message.expects(:valid?).with(nil, against_api: false).returns(true)
        FirebaseCloudMessenger::Message.expects(:new).with(hash_message).returns(mock_message)

        assert FirebaseCloudMessenger.validate_message(hash_message)
      end
    end

    describe "with a message object" do
      it "checks the message for validity" do
        msg = FirebaseCloudMessenger::Message.new(token: "token")
        msg.expects(:valid?).with(nil, against_api: false).returns(true)

        assert FirebaseCloudMessenger.validate_message(msg)
      end
    end
  end
end
