# Changelog 1.2.0

## Bugfixes

* `datetimeReference` is not respected by LUIS when specified as a `GET`. Switched to `POST`
* Renamed `tz_offset` option to `datetime_reference` to more closely match the LUIS API

# Changelog 1.1.0

## Features

* Added intent threshold option; intents with lower scores than the threshold are not matched.

# Changelog 1.0.0

## Bugfixes

* The endpoint is now properly configurable
* Updated gem dependencies
* Fixed README to point out correct config

# Changelog 0.9.0

* Initial release
