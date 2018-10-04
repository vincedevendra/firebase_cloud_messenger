module FirebaseCloudMessenger
  class FirebaseObject
    def initialize(data, fields)
      data = data.dup
      @fields = fields

      fields.each do |field|
        send(:"#{field}=", data.delete(field))
      end

      if data.any?
        raise ArgumentError, "Keys must be one of #{fields.inspect}"
      end
    end

    def to_h
      fields.each_with_object({}) do |field, object_hash|
        val = send(field)
        next if val.nil?
        val = val.to_h if val.is_a?(FirebaseObject)

        object_hash[field] = val
      end
    end

    private

    attr_reader :fields
  end
end
