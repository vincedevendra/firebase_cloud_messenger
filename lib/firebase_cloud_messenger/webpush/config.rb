module FirebaseCloudMessenger
  module Webpush
    class Config < FirebaseObject
      FIELDS = %i(headers data notification).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
