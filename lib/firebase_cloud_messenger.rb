require 'net/http'
require 'googleauth'
require 'json'

require 'firebase_cloud_messenger/auth_client'
require 'firebase_cloud_messenger/error'
require 'firebase_cloud_messenger/client'
require 'firebase_cloud_messenger/firebase_object'
require 'firebase_cloud_messenger/android'
require 'firebase_cloud_messenger/apns'
require 'firebase_cloud_messenger/webpush'


module FirebaseCloudMessenger
  def self.send(message: {}, validate_only: false, conn: nil)
    Client.new.send(message, validate_only, conn)
  end

  def self.validate_message(message, conn = nil)
    send(message: message, validate_only: true, conn: conn)
  end
end
