require 'test_helper'

class FirebaseCloudMessenger::Webpush::ConfigTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::Webpush::Config.new(headers: "headers",
                                                        data: "data",
                                                        notification: "notification",
                                                        fcm_options: "fcm_options")

      %i(headers data notification fcm_options).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Webpush::Config.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      msg = FirebaseCloudMessenger::Webpush::Config.new(headers: "headers",
                                                        data: "data",
                                                        notification: "notification",
                                                        fcm_options: "fcm_options")

      expected = %i(headers data notification fcm_options).each_with_object({}) do |field, hash|
        hash[field] = field.to_s
      end

      assert_equal expected, msg.to_h
    end
  end
end
