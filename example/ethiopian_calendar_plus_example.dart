import 'package:ethiopian_calendar_plus/converters.dart';
import 'package:ethiopian_calendar_plus/ethiopian_date.dart';
import 'package:intl/intl.dart';

void main() {
  // Basic date conversion
  final gregorianDate = DateTime(2024, 3, 20);
  final ethiopianDate =
      EthiopianDateConverter.gregorianToEthiopian(gregorianDate);
  print('Gregorian date: $gregorianDate');
  print('Ethiopian date: $ethiopianDate'); // Output: 2016-07-13

  // Different formatting options
  final dateFormat = DateFormat();

  // Full format with weekday and Amharic month name
  print('Full format: ${dateFormat.formatEthiopianFull(gregorianDate)}');
  // Output: ረቡዕ, 13 መጋቢት 2016

  // Short numeric format
  print('Short format: ${dateFormat.formatEthiopianShort(gregorianDate)}');
  // Output: 13/7/2016

  // Get just the weekday in Amharic
  print('Weekday: ${dateFormat.getEthiopianWeekday(gregorianDate)}');
  // Output: ረቡዕ

  // Convert from Ethiopian to Gregorian
  final backToGregorian =
      EthiopianDateConverter.ethiopianToGregorian(2016, 7, 13);
  print('Back to Gregorian: $backToGregorian');
  // Output: 2024-03-20

  // Working with Ethiopian dates directly
  final ethDate = EthiopianDate(year: 2016, month: 7, day: 13);
  print('Ethiopian date object: $ethDate');
  // Output: 2016-07-13
}
