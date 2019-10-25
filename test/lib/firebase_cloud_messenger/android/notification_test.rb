require 'test_helper'

class FirebaseCloudMessenger::Android::NotificationTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::Android::Notification.new(title: "title",
                                                              body: "body",
                                                              icon: "icon",
                                                              color: "color",
                                                              sound: "sound",
                                                              tag: "tag",
                                                              click_action: "click_action",
                                                              body_loc_key: "body_loc_key",
                                                              body_loc_args: "body_loc_args",
                                                              title_loc_key: "title_loc_key",
                                                              title_loc_args: "title_loc_args",
                                                              image: "image")

      %i(title body icon color sound tag click_action body_loc_key body_loc_args title_loc_key title_loc_args image).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Android::Notification.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      msg = FirebaseCloudMessenger::Android::Notification.new(title: "title",
                                                              body: "body",
                                                              icon: "icon",
                                                              color: "color",
                                                              sound: "sound",
                                                              tag: "tag",
                                                              click_action: "click_action",
                                                              body_loc_key: "body_loc_key",
                                                              body_loc_args: "body_loc_args",
                                                              title_loc_key: "title_loc_key",
                                                              title_loc_args: "title_loc_args",
                                                              image: "image")

      expected = %i(title body icon color sound tag click_action body_loc_key body_loc_args title_loc_key title_loc_args image).each_with_object({}) do |field, hash|
        hash[field] = field.to_s
      end

      assert_equal expected, msg.to_h
    end
  end
end
