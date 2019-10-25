module FirebaseCloudMessenger
  module Apns
    class FcmOptions < ApnsObject
      FIELDS = %i(analytics_label image).freeze

      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
