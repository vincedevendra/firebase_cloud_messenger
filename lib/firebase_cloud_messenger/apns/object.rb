module FirebaseCloudMessenger
  module Apns
    class Object < FirebaseObject
      def to_h
        fields.each_with_object({}) do |field, object_hash|
          val = send(field)
          next if val == false
          val = val.to_h if ![String, Numeric, Boolean, Array].include?(val.class)

          object_hash[field.to_s.gsub("_", "-")] = val
        end
      end
    end
  end
end
