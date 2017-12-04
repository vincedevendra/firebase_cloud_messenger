module FirebaseCloudMessenger
  class FirebaseObject
    def initialize(data, fields)
      @fields = fields

      fields.each do |field|
        send(:"#{field}=", data.delete(field))
      end

      if data.any?
        raise ArgumentError, "Keys must be one on #{fields.inspect}"
      end
    end

    def to_h
      fields.each_with_object({}) do |field, object_hash|
        val = send(field)
        next if val.nil?
        val = val.to_h if [String, Numeric, TrueClass, FalseClass, NilClass, Array].none? { |klass| val.is_a?(klass) }

        object_hash[field] = val
      end
    end

    private

    attr_reader :fields
  end
end
