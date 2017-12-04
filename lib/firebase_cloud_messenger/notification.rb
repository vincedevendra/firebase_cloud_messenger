module FirebaseCloudMessenger
  class Notification < FirebaseObject
    FIELDS = %i(title body)
    attr_accessor(*FIELDS)

    def initialize(data)
      super(data, FIELDS)
    end
  end
end
