module FirebaseCloudMessenger
  module Android
    class LightSettings < FirebaseObject
      FIELDS = %i(color light_on_duration light_off_duration).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
