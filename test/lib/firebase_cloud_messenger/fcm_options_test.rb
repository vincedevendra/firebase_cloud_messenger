require 'test_helper'

class FirebaseCloudMessenger::FcmOptionsTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::FcmOptions.new(analytics_label: "analytics_label")

      %i(analytics_label).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::FcmOptions.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      msg = FirebaseCloudMessenger::FcmOptions.new(analytics_label: "analytics_label")

      expected = %i(analytics_label).each_with_object({}) do |field, hash|
        hash[field.to_sym] = field.to_s
      end

      assert_equal expected, msg.to_h
    end
  end
end
