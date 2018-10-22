# firebase_cloud_messenger

Check out PLM's [blog post](http://tech.patientslikeme.com/2017/12/07/firebase-cloud-messenger.html)
about our development and use of firebase_cloud_messenger for more information about setting up and
getting started.

firebase_cloud_messenger wraps Google's API to make sending push notifications to iOS, android, and
web push notifications from your server easy.

NB: Google released the [FCM HTTP v1 API](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages)
in November 2017, giving legacy status to the older but still supported HTTP and XMPP apis.
This gem only targets the [FCM HTTP v1 API], which Google [recommends using for new projects](https://firebase.google.com/docs/cloud-messaging/server),
because it is the most up-to-date and secure.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'firebase_cloud_messenger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firebase_cloud_messenger

## Setup
In order for google to authenticate requests to Firebase Cloud Messenger, you must either have your
service account credentials file in a place that's accessible, or provide credentials as env vars.

#### Setup Method 1: Service Account JSON Path Supplied As Env Var
```bash
$ export GOOGLE_APPLICATION_CREDENTIALS = "path/to/credentials/file.json"`
```

#### Setup Method 2: Service Account JSON Path Supplied To FirebaseCloudMessenger
```ruby
FirebaseCloudMessenger.credentials_path = "path/to/credentials/file.json"
```

#### Setup Method 3: Service Account Credentials Set as Env Vars
``` bash
$ export GOOGLE_PRIVATE_KEY = "-----BEGIN PRIVATE KEY-----..."
$ export GOOGLE_CLIENT_EMAIL = "firebase-admin-sdk...@iam.gserviceaccount.com"
```
Also set the `project_id`, which is otherwise read from the json service account file:

```ruby
FirebaseCloudMessenger.project_id = "1234567"
```

## Usage

### Sending a Message

You can see how your message should be structured [here](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages)
firebase_cloud_messenger provides built-in data classes for each json object type in the FCM API
specification, but you can also build up a hash message on your own, or use some combination of the
two.

Send messages with built-in data objects, which can be built through a hash argument to the
initializer or via writer methods:
```ruby
android_notification = FirebaseCloudMessenger::Android::Notification.new(title: "title")
android_config = FirebaseCloudMessenger::Android::Config.new(notification: android_notification)
message = FirebaseCloudMessenger::Message.new(android: android_config, token: "a_device_token")

FirebaseCloudMessenger.send(message: message) # => { "name" => "name_from_fcm" }

# OR

android_notification = FirebaseCloudMessenger::Android::Notification.new
android_notification.title = "title"

android_config = FirebaseCloudMessenger::Android::Config.new
android_config.notification = android_notification

message = FirebaseCloudMessenger::Message.new
message.android = android_config
message.token = "a_device_token"

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
  e.short_message # => A message from fcm about what's wrong with the request
  e.response_status # => 400
  e.details # => An array of error details from fcm
end
```

### Message Validation

Many errors can be caught before sending by validating a message before sending it.

Validate your message either by via the Firebase Cloud Messenger API:
```ruby
message = FirebaseCloudMessenger::Message.new(android: { bad: "data" })
message.valid?(against_api: true) # => false
message.errors # => [<error_msg>]
```

or client-side, via json-schema:
```ruby
message = FirebaseCloudMessenger::Message.new(android: { bad: "data" }, token: "a_device_token")
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

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rake test` to run the tests.
