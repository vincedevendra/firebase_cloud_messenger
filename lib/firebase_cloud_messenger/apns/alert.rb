module FirebaseCloudMessenger
  module Apns
    class Alert < Object
      FIELDS = %i(title body title_loc_key title_loc_args action_lock_key loc_key loc_args launch_image).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
