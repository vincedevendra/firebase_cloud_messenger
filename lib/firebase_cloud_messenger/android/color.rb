module FirebaseCloudMessenger
  module Android
    class Color < FirebaseObject
      FIELDS = %i(red green blue alpha).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
