# Stealth LUIS

This integration implements the [Microsoft LUIS](https://luis.ai) Language Understanding service. It utilizes the built-in NLP features part of Stealth 2.x. If you are still using Stealth 1.x, you will first need to upgrade to Stealth 2.x before you can use this integration.

## Entities

The entity types listed below are named using their corresponding Stealth type. The equivalent type used by Microsoft LUIS is also listed. For each code sample, the sample query is first provided followed by the array of entities extracted from the queries (for the given type).

It's possible, and even likely, that a query matches more than one entity type. For example, a `currency` type will also match a `number` type. For more info about how to utilize these types, please see the [Stealth NLP documentation](https://github.com/hellostealth/stealth/wiki/NLP).

### number

LUIS prebuilt entity: `number`

```ruby
"I think it was something like 63 or maybe 764"

[
  63,
  764
]
```

```ruby
"It was almost 15k"

[
  15000
]
```

For more info about these values, please reference the [number entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-number?tabs=V3).

### currency

LUIS prebuilt entity: `money`

```ruby
"send me $87 or 48 cents"

[
  { 'number' => 87, 'units' => 'Dollar' },
  { 'number' => 48, 'units': 'Cent' }
]
```

For more info about these values, please reference the [money entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-currency?tabs=V3).

### email

LUIS prebuilt entity: `email`

```ruby
"you can contact me at john@email.none"

[
  "john@email.none"
]
```

For more info about these values, please reference the [email entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-email?tabs=V3).

### phone

LUIS prebuilt entity: `phonenumber`

Note: LUIS does not parse nor attempts to clean up phone number.

```ruby
"You can reach me at 313-555-1212"

[
  "313-555-1212"
]
```

For more info about these values, please reference the [phonenumber entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-phonenumber?tabs=V3).

### percentage

LUIS prebuilt entity: `percentage`

```ruby
"The stock is up 8.9% today"

[
  8.9
]
```

For more info about these values, please reference the [percentage entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-percentage?tabs=V3).

### age

LUIS prebuilt entity: `age`

```ruby
"81 years old"

[
  { 'number' => 81, 'units' => 'Year' }
]
```

For more info about these values, please reference the [age entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-age?tabs=V3).

### url

LUIS prebuilt entity: `url`

```ruby
"please visit google.com or https://google.com"

[
  "google.com",
  "https://google.com"
]

```

For more info about these values, please reference the [url entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-url?tabs=V3).

### ordinal

LUIS prebuilt entity: `ordinalV2`

```ruby
"they finished 2nd and 5th"

[
  { 'offset' => 2, 'relativeTo' => 'start' },
  { 'offset' => 5, 'relativeTo' => 'start' }
]
```

```ruby
"she finished last"

[
  { 'offset' => 0, 'relativeTo' => 'end' }
]
```

For more info about these values, please reference the [ordinalV2 entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-ordinal-v2?tabs=V3).

### geo

LUIS prebuilt entity: `geographyV2`

```ruby
"She moved to paris, france"

[
  { 'value' => 'paris', 'type' => 'city' },
  { 'value' => 'france', 'type' => 'countryRegion' }
]
```

For more info about these values, please reference the [geographyV2 entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-geographyv2?tabs=V3).

### dimension

LUIS prebuilt entity: `dimension`

```ruby
"it's about 4 inches wide"

[
  { "number": 4, "units": "Inch" }
]
```

For more info about these values, please reference the [dimension entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-dimension?tabs=V3).

### temp

LUIS prebuilt entity: `temperature`

```ruby
"it feels like 98 degrees"

[
  { 'number' => 98, 'units' => 'Degree' }
]
```

For more info about these values, please reference the [temperature entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-temperature?tabs=V3).

### datetime

LUIS prebuilt entity: `datetimeV2`

```ruby
"How about Mar 12?"

[
  {
    "type": "date",
    "values": [
      {
        "timex": "XXXX-03-12",
        "resolution": [
          {
            "value": "2019-03-12"
          },
          {
            "value": "2020-03-12"
          }
        ]
      }
    ]
  }
]
```

For more info about these values, please reference the [datetimeV2 entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-datetimev2?tabs=1-1%2C2-1%2C3-1%2C4-1%2C5-1%2C6-1#types-of-datetimev2).

### duration

LUIS prebuilt domain entity: `Calendar.Duration`

```ruby
"it will be between 15 minutes and 3 hours"

[
  "15 minutes",
  "3 hours"
]
```

_Additional docs for this prebuilt domain entitiy is not available_

### key_phrase

LUIS prebuilt entity: `keyPhrase`

```ruby
"I need to find the instructional materials for the course"

[
  "instructional materials",
  "course"
]
```

For more info about these values, please reference the [keyPhrase entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-keyphrase?tabs=V3).

### name

LUIS prebuilt entity: `personName`

```ruby
"Little Cindy-Lou Who who was not more than two"

[
  "Little Cindy-Lou"
]
```

For more info about these values, please reference the [personName entity LUIS documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/luis/luis-reference-prebuilt-person?tabs=V3).
