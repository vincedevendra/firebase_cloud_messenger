module FirebaseCloudMessenger
  class Message < FirebaseObject
    FIELDS = %i(name data notification android webpush apns token topic condition).freeze
    attr_accessor(*FIELDS)

    attr_writer :errors

    def initialize(data)
      super(data, FIELDS)
    end

    def validate!
      begin
        FirebaseCloudMessenger.validate_message(self)
      rescue BadRequest => e
        self.errors += e.error_details
        return false
      end

      true
    end

    def errors
      @errors ||= []
    end
  end
end
