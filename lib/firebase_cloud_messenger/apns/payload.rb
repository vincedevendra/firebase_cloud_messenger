module FirebaseCloudMessenger
  module Apns
    class Payload < ApnsObject
      FIELDS = %i(aps)

      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
