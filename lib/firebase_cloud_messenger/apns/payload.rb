module FirebaseCloudMessenger
  module Apns
    class Payload < ApnsObject
      FIELDS = %i(alert badge sound content_available category thread_id).freeze

      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
