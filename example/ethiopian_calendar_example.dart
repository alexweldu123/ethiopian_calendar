import 'package:ethiopian_calendar_plus/ethiopian_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  // Convert from Gregorian to Ethiopian
  final gregorianDate = DateTime(2024, 3, 20);
  final ethiopianDate =
      EthiopianDateConverter.gregorianToEthiopian(gregorianDate);
  print('Gregorian date: $gregorianDate');
  print('Ethiopian date: $ethiopianDate'); // 2016-07-13

  // Format dates
  final dateFormat = DateFormat();
  print(
      'Ethiopian date (full): ${dateFormat.formatEthiopianFull(gregorianDate)}');
  print(
      'Ethiopian date (short): ${dateFormat.formatEthiopianShort(gregorianDate)}');

  // Convert from Ethiopian to Gregorian
  final backToGregorian =
      EthiopianDateConverter.ethiopianToGregorian(2016, 7, 13);
  print('Back to Gregorian: $backToGregorian');
}
