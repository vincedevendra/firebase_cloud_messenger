module FirebaseCloudMessenger
  module Apns
    class ApsDictionary < ApnsObject
      FIELDS = %i(alert badge sound content_available mutable_content category thread_id).freeze

      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
