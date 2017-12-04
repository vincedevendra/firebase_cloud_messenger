module FirebaseCloudMessenger
  class FirebaseObject
    attr_writer :errors

    def initialize(data, fields)
      @fields = fields

      data.default = false

      fields.each do |field|
        send(:"#{field}=", data.delete(field))
      end

      if data.any?
        raise ArgumentError, "Keys must be one on #{fields.inspect}"
      end
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

    def to_h
      fields.each_with_object({}) do |field, object_hash|
        val = send(field)
        next if val == false
        val = val.to_h if ![String, Numeric, TrueClass, FalseClass, NilClass, Array].include?(val.class)

        object_hash[field] = val
      end
    end

    def errors
      @errors ||= []
    end

    private

    attr_reader :fields
  end
end
