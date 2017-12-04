module FirebaseCloudMessenger
  module Apns
    class Alert < ApnsObject
      FIELDS = %i(title body title_loc_key title_loc_args action_loc_key loc_key loc_args launch_image).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
