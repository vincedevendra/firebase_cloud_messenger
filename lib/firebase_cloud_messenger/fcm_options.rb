module FirebaseCloudMessenger
  class FcmOptions < FirebaseObject
    FIELDS = %i(analytics_label).freeze

    attr_accessor(*FIELDS)

    def initialize(data)
      super(data, FIELDS)
    end
  end
end
