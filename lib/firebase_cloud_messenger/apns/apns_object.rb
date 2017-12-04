module FirebaseCloudMessenger
  module Apns
    class ApnsObject < FirebaseObject
      def to_h
        fields.each_with_object({}) do |field, object_hash|
          val = send(field)
          next if val.nil?
          val = val.to_h if [String, Numeric, TrueClass, FalseClass, NilClass, Array].none? { |klass| val.is_a?(klass) }

          object_hash[field.to_s.gsub("_", "-").to_sym] = val
        end
      end
    end
  end
end
