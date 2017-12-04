require 'test_helper'

class FirebaseCloudMessenger::Android::ConfigTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::Android::Config.new(collapse_key: "collapse_key",
                                                        priority: "priority",
                                                        ttl: "ttl",
                                                        restricted_package_name: "restricted_package_name",
                                                        data: "data",
                                                        notification: "notification")

      %i(collapse_key priority ttl restricted_package_name data notification).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Android::Config.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      msg = FirebaseCloudMessenger::Android::Config.new(collapse_key: "collapse_key",
                                                        priority: "priority",
                                                        ttl: "ttl",
                                                        restricted_package_name: "restricted_package_name",
                                                        data: "data",
                                                        notification: "notification")

      expected = %i(collapse_key priority ttl restricted_package_name data notification).each_with_object({}) do |field, hash|
        hash[field] = field.to_s
      end

      assert_equal expected, msg.to_h
    end
  end
end
