module FirebaseCloudMessenger
  class BaseError < StandardError; end
  class SetupError < BaseError; end

  class Error < BaseError
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

    def short_message
      parsed_response["error"]["message"]
    end

    private

    def error_message
      return nil if response.nil?

      <<-MSG


Status: #{response_status}

Message: #{short_message}

Details: #{details}
      MSG
    end
  end

  class BadRequest < Error; end
  class Unauthorized < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end

  class Timeout < BaseError; end
  class ConnectTimeout < Timeout; end
  class ReadTimeout < Timeout; end
end
