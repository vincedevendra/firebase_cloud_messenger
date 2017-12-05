require 'net/http'
require 'googleauth'
require 'json'

require 'firebase_cloud_messenger/auth_client'
require 'firebase_cloud_messenger/error'
require 'firebase_cloud_messenger/client'
require 'firebase_cloud_messenger/firebase_object'
require 'firebase_cloud_messenger/message'
require 'firebase_cloud_messenger/notification'
require 'firebase_cloud_messenger/android'
require 'firebase_cloud_messenger/apns'
require 'firebase_cloud_messenger/webpush'


module FirebaseCloudMessenger
  class << self
    attr_accessor :credentials_path
  end

  def self.send(message: {}, validate_only: false, conn: nil)
    Client.new(credentials_path).send(message, validate_only, conn)
  end

  def self.validate_message(message, conn = nil, against_api: false)
    message = Message.new(message) if message.is_a?(Hash)

    message.valid?(conn, against_api: against_api)
  end
end
