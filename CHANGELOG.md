## Version 0.3.0 - February 6, 2017
* Adds `NotFound` error class and raises for 404 responses

## Version 0.2.1 - December 22, 2017
* Fixes bug causing closed credentials file to be passed to the googleauth library. (Thanks to
  @tomek1024 for the patch.)

## Version 0.2.0 - December 12, 2017

* Allows Google service account credentials to be set either via environment variables or a path to
  a json file. Previously only the json file option was available.
