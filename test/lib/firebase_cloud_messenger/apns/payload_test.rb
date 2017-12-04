require 'test_helper'

class FirebaseCloudMessenger::Apns::PayloadTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::Apns::Payload.new(alert: "alert",
                                                      badge: "badge",
                                                      sound: "sound",
                                                      content_available: "content_available",
                                                      category: "category",
                                                      thread_id: "thread_id")

      %i(alert badge sound content_available category thread_id).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Apns::Payload.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      msg = FirebaseCloudMessenger::Apns::Payload.new(alert: "alert",
                                                      badge: "badge",
                                                      sound: "sound",
                                                      content_available: "content_available",
                                                      category: "category",
                                                      thread_id: "thread_id")

      expected = %i(alert badge sound content_available category thread_id).each_with_object({}) do |field, hash|
        hash[field.to_s.gsub("_", "-").to_sym] = field.to_s
      end

      assert_equal expected, msg.to_h
    end
  end
end
