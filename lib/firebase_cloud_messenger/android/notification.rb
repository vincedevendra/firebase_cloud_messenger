module FirebaseCloudMessenger
  module Android
    class Notification < FirebaseObject
      FIELDS = %i(
        title
        body
        icon
        color
        sound
        tag
        click_action
        body_loc_key
        body_loc_args
        title_loc_key
        title_loc_args
        sticky
        event_time
        local_only
        notification_priority
        default_sound
        default_vibrate_timings
        default_light_settings
        vibrate_timings
        visibility
        notification_count
        light_settings
        image
      ).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
