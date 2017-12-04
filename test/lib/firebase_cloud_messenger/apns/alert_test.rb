require 'test_helper'

class FirebaseCloudMessenger::Apns::AlertTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::Apns::Alert.new(title: "title",
                                                    body: "body",
                                                    title_loc_key: "title_loc_key",
                                                    title_loc_args: "title_loc_args",
                                                    action_loc_key: "action_loc_key",
                                                    loc_key: "loc_key",
                                                    loc_args: "loc_args",
                                                    launch_image: "launch_image")

      %i(title body title_loc_key title_loc_args action_loc_key loc_key loc_args launch_image).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Apns::Alert.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      msg = FirebaseCloudMessenger::Apns::Alert.new(title: "title",
                                                    body: "body",
                                                    title_loc_key: "title_loc_key",
                                                    title_loc_args: "title_loc_args",
                                                    action_loc_key: "action_loc_key",
                                                    loc_key: "loc_key",
                                                    loc_args: "loc_args",
                                                    launch_image: "launch_image")

      expected = %i(title body title_loc_key title_loc_args action_loc_key loc_key loc_args launch_image).each_with_object({}) do |field, hash|
        hash[field.to_s.gsub("_", "-").to_sym] = field.to_s
      end

      assert_equal expected, msg.to_h
    end
  end
end
