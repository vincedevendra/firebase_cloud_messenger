require 'test_helper'

class FirebaseCloudMessenger::ClientTest < MiniTest::Spec
  describe "#valid?" do
    it "returns the true if there are no errors" do
      message = FirebaseCloudMessenger::Message.new(valid: "data")

      FirebaseCloudMessenger.expects(:validate_message).with(message).returns(true)
      valid = message.valid?

      assert_equal true, valid
    end

    it "adds errors and returns false there are any errors" do
      message = FirebaseCloudMessenger::Message.new(invalid: "data")

      error = FirebaseCloudMessenger::BadRequest.new
      error.stubs(error_details: ["bad", "data"])
      FirebaseCloudMessenger.expects(:validate_message).with(message).raises(error)

      message_valid = message.valid?

      assert_equal ["bad", "data"], message.errors
      refute message_valid
    end
  end
end
