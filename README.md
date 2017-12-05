# firebase-cloud-messenger

firebase-cloud-messenger wraps Google's API to make sending push notifications to iOS, android, and
web push notifications from your server easy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'firebase_cloud_messenger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firebase_cloud_messenger

In order for google to authenticate requests to Firebase Cloud Messenger, you must have your
credentials file in a place that's accessible. You can tell firebase-cloud-messenger where it is in
two ways:

1. `FirebaseCloudMessenger.credentials_path = "path/to/credentials/file.json"`
2. `export GOOGLE_APPLICATION_CREDENTIALS = "path/to/credentials/file.json"`

## Usage

### Sending a Message

Send messages with built-in data objects:
```ruby
android_notification = FirebaseCloudMessenger::Android::Notification.new(title: "title")
android_config = FirebaseCloudMessenger::Android::AndroidConfig.new(notification: android_notification)
message = FirebaseCloudMessenger::Message.new(android: android_config, token "a_device_token")

FirebaseCloudMessenger.send(message: message) # => { "name" => "name_from_fcm" }
```

or with just a hash:

```ruby
message = {
  android: {
    notification: {
      title: "title"
    }
  },
  token: "a_device_token"
}

FirebaseCloudMessenger.send(message: message) # => { "name" => "name_from_fcm" }
```

or some combination of the two:

```ruby
message = FirebaseCloudMessenger::Message.new(android: { notification: { title: "title" }, token: "a_device_token" })
FirebaseCloudMessenger.send(message: message) # => { "name" => "name_from_fcm" }
```

### Error Handling

If something goes wrong, `::send` will raise an instance of a subclass of `FirebaseCloudMessenger::Error` with
helpful info on what went wrong:
```ruby
message = FirebaseCloudMessenger::Message.new(android: { bad: "data" }, token: "a_device_token"})
begin
  FirebaseCloudMessenger.send(message: message)
rescue FirebaseCloudMessenger::Error => e
  e.class # => FirebaseCloudMessenger::BadRequest
  e.message # => A message from fcm about what's wrong with the request
  e.status # => 400
  e.error_details # => An array of error details from fcm
end
```

### Message Validation

Many errors can be caught before sending by validating a message before sending it.

Validate your message either by via the Firebase Cloud Messenger API:
```ruby
message = FirebaseCloudMessenger.new(android: { bad: "data" })
message.valid?(against_api: true) # => false
message.errors # => [<error_msg>]
```

or client-side, via json-schema:
```ruby
message = FirebaseCloudMessenger.new(android: { bad: "data" }, token: "a_device_token")
message.valid? # => false
message.errors # => ["The property '#/android' contains additional properties [\"bad\"] outside of the schema when none are allowed in schema..."]
```

Validate your hash message (returns only true or false):
```ruby
message = {
  android: { bad: "data" },
  token: "a_device_token"
}

#api-side
FirebaseCloudMessenger.validate_message(message, against_api: true) # => false

#OR

#client-side
FirebaseCloudMessenger.validate_message(message) # => false

```


## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake test` to run the tests.
