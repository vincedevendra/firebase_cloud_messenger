module FirebaseCloudMessenger
  SCHEMA = {
    "definitions" => {
      "data" => {
        "type" => "object",
        "additional_properties" => { "type" => "string" }
      },
      "notification" => {
        "type" => "object",
        "properties" => {
          "title" => { "type" => "string" },
          "body"  => { "type" => "string" }
        },
        "additional_properties" => false
      },
      "android_config" => {
        "type" => "object",
        "properties" => {
          "collapse_key"             => { "type" => "string" },
          "priority"                 => { "type" => "string", "enum" => ["NORMAL", "HIGH"] },
          "ttl"                      => { "type" => "string", "format" => "^[0-9]+\.[0-9]+s$" },
          "restricted_package_name"  => { "type" => "string" },
          "data"                     => { "$ref" => "#/definitions/data" },
          "notification"             => { "$ref" => "#/definitions/android_notificatoin" }
        },
        "additional_properties" => false
      },
      "android_notification" => {
        "type" => "object",
        "properties" => {
          "title"          => { "type" => "string" },
          "body"           => { "type" => "string" },
          "icon"           => { "type" => "string" },
          "color"          => { "type" => "string" },
          "sound"          => { "type" => "string" },
          "tag"            => { "type" => "string" },
          "click_action"   => { "type" => "string" },
          "body_loc_key"   => { "type" => "string" },
          "body_loc_args"  => { "type" => "array", "items" => { "type" => "string" } },
          "title_loc_key"  => { "type" => "string" },
          "title_loc_args" => { "type" => "array", "items" => { "type" => "string" } }
        },
        "additional_properties" => false
      },
      "webpush_config" => {
        "type" => "object",
        "properties" => {
          "headers"      => { "$ref" => "#/definitions/data" },
          "data"         => { "$ref" => "#/definitions/data" },
          "notification" => { "$ref" => "#/definitions/webpush_notification" }
        },
        "additional_properties" => false
      },
      "webpush_notification" => {
        "type" => "object",
        "properties" => {
          "title"          => { "type" => "string" },
          "body"           => { "type" => "string" },
          "icon"           => { "type" => "string" }
        },
        "additional_properties" => false
      },
      "apns" => {
        "type" => "object",
        "properties" => {
          "headers" => { "$ref" => "#/definitions/data" },
          "payload" => { "$ref" => "#/definitions/apns_payload" }
        },
        "additional_properties" => false
      },
      "apns_alert" => {
        "anyOf" => [
          { "type" => "string" },
          {
            "type" => "object",
            "properties" => {
              "title"          => { "type" => "string" },
              "body"           => { "type" => "string" },
              "title-loc-key " => { "anyOf" => [ { "type" => "string" }, { "type" => "null" } ] },
              "title-loc-args" => { "anyOf" => [ { "type" => "array", "items" => { "type" => "string" } }, { "type" => "null" }] },
              "action-loc-key" => { "anyOf" => [ { "type" => "string" }, { "type" => "null" } ] },
              "loc-key"        => { "type" => "string" },
              "loc-args"       => { "type" => "array", "items" => { "type" => "string" } },
              "launch-image"   => { "type" => "string" }
            },
            "additional_properties" => false
          }
        ]
      },
      "apns_payload" => {
        "type" => "object",
        "properties" => {
          "alert"             => { "$ref" => "#/definitions/apns_alert" },
          "badge"             => { "type" => "number" },
          "sound"             => { "type" => "string" },
          "content-available" => { "type" => "number" },
          "category"          => { "type" => "string" },
          "thread-id"         => { "type" => "string" }
        },
        "additional_properties" => false
      }
    },
    "type" => "object",
    "properties" => {
      "data"         => { "$ref" => "#/definitions/data" },
      "notification" => { "$ref" => "#/definitions/notification" },
      "android"      => { "$ref" => "#/definitions/android" },
      "webpush"      => { "$ref" => "#/definitions/webpush" },
      "apns"         => { "$ref" => "#/definitions/apns" },
      "token"        => { "type" => "string" },
      "topic"        => { "type" => "topic" },
      "condition"    => { "type" => "string" }
    },
    "additional_properties" => false,
    "oneOf" => [
      { "required" => ["token"] },
      { "required" => ["topic"] },
      { "required" => ["condition"] }
    ]
  }
end
