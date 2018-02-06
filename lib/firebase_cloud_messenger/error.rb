module FirebaseCloudMessenger
  class SetupError < StandardError; end

  class Error < StandardError
    attr_reader :response

    def self.from_response(response)
      status = response.code

      klass = case status.to_i
              when 400 then FirebaseCloudMessenger::BadRequest
              when 401 then FirebaseCloudMessenger::Unauthorized
              when 403 then FirebaseCloudMessenger::Forbidden
              when 404 then FirebaseCloudMessenger::NotFound
              else self
              end

      klass.new(response)
    end

    def initialize(response = nil)
      @response = response

      super(error_message)
    end

    def response_status
      response.code.to_i
    end

    def response_body
      response.body
    end

    def parsed_response
      JSON.parse(response_body)
    end

    def details
      parsed_response["error"]["details"]
    end

    private

    def error_message
      return nil if response.nil?

      <<-MSG
      Status: #{response_status}

      #{parsed_response["error"]["message"]}
      MSG
    end
  end

  class BadRequest < Error; end
  class Unauthorized < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end
end
