module FirebaseCloudMessenger
  module Android
    class Config < FirebaseObject
      FIELDS = %i(collapse_key priority ttl restricted_package_name data notification).freeze
      attr_accessor(*FIELDS)

      def initialize(data)
        super(data, FIELDS)
      end
    end
  end
end
