module FirebaseCloudMessenger
  class Message < FirebaseObject
    FIELDS = %i(name data notification android webpush apns token topic condition).freeze
    attr_accessor(*FIELDS)

    def initialize(data)
      super(data, FIELDS)
    end
  end
end
