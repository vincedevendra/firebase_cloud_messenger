require 'firebase_cloud_messenger/firebase_object'

module FirebaseCloudMessenger
  class Message < FirebaseObject
    FIELDS = %i(name data notification android webpush apns token topic condition).freeze
    attr_accessor(*FIELDS)

    def initialize(data)
      set_field_vars(data, FIELDS)
    end
  end
end
