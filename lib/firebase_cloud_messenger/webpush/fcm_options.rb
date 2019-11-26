module FirebaseCloudMessenger
  module Webpush
    class FcmOptions < FirebaseObject
      FIELDS = %i(link).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
