module FirebaseCloudMessenger
  module Webpush
    class Notification < FirebaseObject
      FIELDS = %i(title body icon).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
