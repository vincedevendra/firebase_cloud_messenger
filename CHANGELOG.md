## Version 0.4.1 - March 12, 2019
* Reorganizes exception hierarchy

## Version 0.4.0 - April 30, 2018
* Adds support for rich notifications in iOS by allowing the mutable-content aps dict key
* Fixes bug that mutated the hash argument `::new` in subclasses of `FirebaseObject`
* Readme fixes
* Big thanks to @freestyl3r for all the patches in this release!

## Version 0.3.1 - April 23, 2018
* Fixes APNS message structure
* Improves format of error messaging for easier debugging

## Version 0.3.0 - February 6, 2017
* Adds `NotFound` error class and raises for 404 responses

## Version 0.2.1 - December 22, 2017
* Fixes bug causing closed credentials file to be passed to the googleauth library. (Thanks to
  @tomek1024 for the patch.)

## Version 0.2.0 - December 12, 2017

* Allows Google service account credentials to be set either via environment variables or a path to
  a json file. Previously only the json file option was available.
