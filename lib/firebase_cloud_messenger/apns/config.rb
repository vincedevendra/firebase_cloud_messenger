module FirebaseCloudMessenger
  module Apns
    class Config < Object
      FIELDS = %i(headers payload).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
