module FirebaseCloudMessenger
  module Android
    class Notification < FirebaseObject
      FIELDS = %i(title body icon color sound tag click_action body_loc_key body_loc_args title_loc_key title_loc_args).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
