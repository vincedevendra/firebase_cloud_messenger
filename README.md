# FirebaseCloudMessenger

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

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake test` to run the tests.
