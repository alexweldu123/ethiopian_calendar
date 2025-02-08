<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Ethiopian Calendar

[![Pub Version](https://img.shields.io/pub/v/ethiopian_calendar)](https://pub.dev/packages/ethiopian_calendar)
[![Build Status](https://github.com/yourusername/ethiopian_calendar/workflows/CI/badge.svg)](https://github.com/yourusername/ethiopian_calendar/actions)
[![Coverage Status](https://coveralls.io/repos/github/yourusername/ethiopian_calendar/badge.svg?branch=main)](https://coveralls.io/github/yourusername/ethiopian_calendar?branch=main)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Pub Points](https://img.shields.io/pub/points/ethiopian_calendar)](https://pub.dev/packages/ethiopian_calendar/score)
[![Pub Popularity](https://img.shields.io/pub/popularity/ethiopian_calendar)](https://pub.dev/packages/ethiopian_calendar/score)
[![Pub Likes](https://img.shields.io/pub/likes/ethiopian_calendar)](https://pub.dev/packages/ethiopian_calendar/score)

A Dart package for working with the Ethiopian Calendar (also known as Ge'ez Calendar), providing easy conversion between Ethiopian and Gregorian dates along with localized formatting options.

## Features

- Convert dates between Ethiopian and Gregorian calendars
- Format Ethiopian dates in various styles (full, short, etc.)
- Support for Amharic month and day names
- Extension methods for easy date formatting
- Accurate handling of Ethiopian calendar's unique characteristics:
  - 13 months (12 months of 30 days + 1 month of 5/6 days)
  - Different new year (September 11/12)
  - ~7/8 years difference from Gregorian calendar

## Getting Started

Add this package to your project's `pubspec.yaml`:

```yaml
dependencies:
  ethiopian_calendar: ^1.0.0
  intl: ^any  # Required dependency
```

## Usage

### Basic Date Conversion

```dart
import 'package:ethiopian_calendar/ethiopian_calendar.dart';

void main() {
  // Convert from Gregorian to Ethiopian
  final gregorianDate = DateTime(2024, 3, 20);
  final ethiopianDate = EthiopianDateConverter.gregorianToEthiopian(gregorianDate);
  print(ethiopianDate); // Output: 2016-07-11

  // Convert from Ethiopian to Gregorian
  final backToGregorian = EthiopianDateConverter.ethiopianToGregorian(2016, 7, 11);
  print(backToGregorian); // Output: 2024-03-20
}
```

### Formatting Ethiopian Dates

```dart
import 'package:ethiopian_calendar/ethiopian_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  final date = DateTime(2024, 3, 20);
  final dateFormat = DateFormat();

  // Format with Amharic month names
  print(dateFormat.formatEthiopian(date)); 
  // Output: 11 መጋቢት 2016

  // Short format
  print(dateFormat.formatEthiopianShort(date)); 
  // Output: 11/7/2016

  // Full format with weekday
  print(dateFormat.formatEthiopianFull(date)); 
  // Output: ረቡዕ, 11 መጋቢት 2016

  // Get Ethiopian weekday
  print(dateFormat.getEthiopianWeekday(date)); 
  // Output: ረቡዕ
}
```

### Working with Ethiopian Dates Directly

```dart
import 'package:ethiopian_calendar/ethiopian_calendar.dart';

void main() {
  final ethiopianDate = EthiopianDate(
    year: 2016,
    month: 7,
    day: 11,
  );
  
  print(ethiopianDate.toString()); // Output: 2016-07-11
}
```

## Additional Information

### Ethiopian Calendar Overview

The Ethiopian calendar:

- Is approximately 7-8 years behind the Gregorian calendar
- Has 13 months (12 months of 30 days each, plus a shorter 13th month)
- Starts its new year on September 11 (or September 12 in leap years)
- Uses its own era, called "Amätä Məhrät" (AM)

### Contributing

Contributions are welcome! If you find a bug or want to add a feature:

1. Open an issue to discuss the change
2. Create a pull request with your changes
3. Ensure all tests pass
4. Update documentation as needed

### License

This project is licensed under the MIT License - see the LICENSE file for details.
