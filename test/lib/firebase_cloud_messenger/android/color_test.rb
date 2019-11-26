require 'test_helper'

class FirebaseCloudMessenger::Android::ColorTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      color = FirebaseCloudMessenger::Android::Color.new(
        red: "red",
        green: "green",
        blue: "blue",
        alpha: "alpha"
      )

      %i(red green blue alpha).each do |field|
        assert_equal field.to_s, color.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Android::Color.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      color = FirebaseCloudMessenger::Android::Color.new(
        red: "red",
        green: "green",
        blue: "blue",
        alpha: "alpha"
      )

      expected = %i(red green blue alpha).each_with_object({}) do |field, hash|
        hash[field] = field.to_s
      end

      assert_equal expected, color.to_h
    end
  end
end
