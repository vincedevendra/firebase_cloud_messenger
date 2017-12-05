module FirebaseCloudMessenger
  module Apns
    class ApnsObject < FirebaseObject
      def to_h
        fields.each_with_object({}) do |field, object_hash|
          val = send(field)
          next if val.nil?
          val = val.to_h if val.is_a?(FirebaseObject)

          object_hash[field.to_s.gsub("_", "-").to_sym] = val
        end
      end
    end
  end
end
