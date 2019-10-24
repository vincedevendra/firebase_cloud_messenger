require 'test_helper'

class FirebaseCloudMessenger::NotificationTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      msg = FirebaseCloudMessenger::Notification.new(title: "title",
                                                     body: "body",
                                                     image: "image")

      %i(title body).each do |field|
        assert_equal field.to_s, msg.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Notification.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      msg = FirebaseCloudMessenger::Notification.new(title: "title",
                                                     body: "body",
                                                     image: "image")

      expected = %i(title body image).each_with_object({}) do |field, hash|
        hash[field] = field.to_s
      end

      assert_equal expected, msg.to_h
    end
  end
end
