require 'test_helper'

class FirebaseCloudMessenger::MessageTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::Message.new(name: "name",
                                                data: "data",
                                                notification: "notification",
                                                android: "android",
                                                webpush: "webpush",
                                                apns: "apns",
                                                token: "token",
                                                topic: "topic",
                                                condition: "condition")

      %i(name data notification android webpush apns token topic condition).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Message.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      data = { some: "data" }
      notification = FirebaseCloudMessenger::Notification.new(title: "title")

      android_notification = FirebaseCloudMessenger::Android::Notification.new(title: "title")
      android_config = FirebaseCloudMessenger::Android::Config.new(notification: android_notification)

      webpush_notification = FirebaseCloudMessenger::Webpush::Notification.new(title: "title")
      webpush_config = FirebaseCloudMessenger::Webpush::Config.new(notification: webpush_notification)

      apns_alert = FirebaseCloudMessenger::Apns::Alert.new(title: "title")
      apns_payload = FirebaseCloudMessenger::Apns::Payload.new(alert: apns_alert, badge: 2)
      apns_config = FirebaseCloudMessenger::Apns::Config.new(payload: apns_payload)

      msg = FirebaseCloudMessenger::Message.new(name: "name",
                                                data: data,
                                                notification: notification,
                                                android: android_config,
                                                webpush: webpush_config,
                                                apns: apns_config,
                                                token: "token",
                                                topic: "topic",
                                                condition: "condition")

      expected = {
        name: "name",
        data: { some: "data" },
        notification: { title: "title" },
        android: { notification: { title: "title" } },
        webpush: { notification: { title: "title" } },
        apns: { payload: { alert: { title: "title" }, badge: 2 } },
        token: "token",
        topic: "topic",
        condition: "condition"
      }

      assert_equal expected, msg.to_h
    end
  end

  describe "#validate" do
     it "returns the true if there are no errors" do
       message = FirebaseCloudMessenger::Message.new(name: "name")

       FirebaseCloudMessenger.expects(:validate_message).with(message).returns(true)
       valid = message.validate!

       assert_equal true, valid
     end

     it "adds errors and returns false there are any errors" do
       message = FirebaseCloudMessenger::Message.new(name: "name")

       error = FirebaseCloudMessenger::BadRequest.new
       error.stubs(error_details: ["bad", "data"])
       FirebaseCloudMessenger.expects(:validate_message).with(message).raises(error)

       message_valid = message.validate!

       assert_equal ["bad", "data"], message.errors
       refute message_valid
     end
  end
end
