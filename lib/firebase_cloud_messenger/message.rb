require 'firebase_cloud_messenger/schema'
require 'json-schema'

module FirebaseCloudMessenger
  class Message < FirebaseObject
    FIELDS = %i(name data notification android webpush apns token topic condition).freeze
    attr_accessor(*FIELDS)

    attr_writer :errors

    def initialize(data)
      super(data.dup, FIELDS)
    end

    def valid?(conn = nil, against_api: false)
      if against_api
        validate_against_api!(conn)
      else
        validate_against_schema
      end

      errors.none?
    end

    def errors
      @errors ||= []
    end

    private

    def validate_against_api!(conn)
      begin
        FirebaseCloudMessenger.send(message: self, validate_only: true, conn: conn)
      rescue FirebaseCloudMessenger::Error => e
        if e.details
          self.errors += e.details
        else
          self.errors << e.parsed_response["error"]["message"]
        end
      end
    end

    def validate_against_schema
      self.errors += JSON::Validator.fully_validate(FirebaseCloudMessenger::SCHEMA, to_h)
    end
  end
end
