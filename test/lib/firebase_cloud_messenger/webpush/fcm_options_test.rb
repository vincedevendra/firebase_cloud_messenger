require 'test_helper'

class FirebaseCloudMessenger::Webpush::FcmOptionsTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      fcm_options = FirebaseCloudMessenger::Webpush::FcmOptions.new(
        link: "link"
      )

      %i(link).each do |field|
        assert_equal field.to_s, fcm_options.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Webpush::FcmOptions.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      fcm_options = FirebaseCloudMessenger::Webpush::FcmOptions.new(
        link: "link"
      )

      expected = %i(link).each_with_object({}) do |field, hash|
        hash[field] = field.to_s
      end

      assert_equal expected, fcm_options.to_h
    end
  end
end
