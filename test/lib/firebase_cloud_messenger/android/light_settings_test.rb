require 'test_helper'

class FirebaseCloudMessenger::Android::LightSettingsTest < MiniTest::Spec
  describe "#new" do
    it "sets properties based on the hash arg" do
      light_settings = FirebaseCloudMessenger::Android::LightSettings.new(
        color: "color",
        light_on_duration: "light_on_duration",
        light_off_duration: "light_off_duration"
      )

      %i(color light_on_duration light_off_duration).each do |field|
        assert_equal field.to_s, light_settings.send(field)
      end
    end

    it "throws an ArgumentError if key is not in fields" do
      assert_raises ArgumentError do
        FirebaseCloudMessenger::Android::LightSettings.new(foo: "foo")
      end
    end
  end

  describe "#to_h" do
    it "returns a hash version of the object" do
      light_settings = FirebaseCloudMessenger::Android::LightSettings.new(
        color: "color",
        light_on_duration: "light_on_duration",
        light_off_duration: "light_off_duration"
      )

      expected = %i(color light_on_duration light_off_duration).each_with_object({}) do |field, hash|
        hash[field] = field.to_s
      end

      assert_equal expected, light_settings.to_h
    end
  end
end
