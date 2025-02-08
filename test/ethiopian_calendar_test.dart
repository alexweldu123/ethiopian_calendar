import 'package:test/test.dart';

import 'package:ethiopian_calendar_plus/ethiopian_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });

  group('EthiopianDate Tests', () {
    test('toString formats date correctly', () {
      final date = EthiopianDate(year: 2016, month: 7, day: 13);
      expect(date.toString(), equals('2016-07-13'));
    });

    test('toString pads single digit month and day with zero', () {
      final date = EthiopianDate(year: 2016, month: 7, day: 5);
      expect(date.toString(), equals('2016-07-05'));
    });
  });

  group('EthiopianDateConverter Tests', () {
    test('converts Gregorian to Ethiopian date correctly', () {
      final gregorianDate = DateTime(2024, 3, 20);
      final ethiopianDate =
          EthiopianDateConverter.gregorianToEthiopian(gregorianDate);

      expect(ethiopianDate.year, equals(2016));
      expect(ethiopianDate.month, equals(7));
      expect(ethiopianDate.day, equals(13));
    });

    test('converts Ethiopian to Gregorian date correctly', () {
      final gregorianDate =
          EthiopianDateConverter.ethiopianToGregorian(2016, 7, 13);

      expect(gregorianDate.year, equals(2023));
      expect(gregorianDate.month, equals(3));
      expect(gregorianDate.day, equals(24));
    });

    test('handles leap year correctly', () {
      // 2024 is a leap year
      final gregorianDate = DateTime(2024, 2, 29);
      final ethiopianDate =
          EthiopianDateConverter.gregorianToEthiopian(gregorianDate);

      expect(ethiopianDate.year, equals(2016));
      expect(ethiopianDate.month, equals(6));
      expect(ethiopianDate.day, equals(21));
    });

    test('handles Pagume (13th month) correctly', () {
      final gregorianDate = DateTime(2024, 9, 5);
      final ethiopianDate =
          EthiopianDateConverter.gregorianToEthiopian(gregorianDate);

      expect(ethiopianDate.year, equals(2016));
      expect(ethiopianDate.month, equals(12));
      expect(ethiopianDate.day, equals(27));
    });
  });

  group('Date Formatting Tests', () {
    final dateFormat = DateFormat();
    final testDate = DateTime(2024, 3, 20);

    test('formats Ethiopian date with Amharic month names', () {
      final formatted = dateFormat.formatEthiopian(testDate);
      expect(formatted, equals('13 መጋቢት 2016'));
    });

    test('formats Ethiopian date in short format', () {
      final formatted = dateFormat.formatEthiopianShort(testDate);
      expect(formatted, equals('13/7/2016'));
    });

    test('gets Ethiopian weekday correctly', () {
      final weekday = dateFormat.getEthiopianWeekday(testDate);
      expect(weekday, equals('ረቡዕ')); // Wednesday
    });

    test('formats Ethiopian date in full format', () {
      final formatted = dateFormat.formatEthiopianFull(testDate);
      expect(formatted, equals('ረቡዕ, 13 መጋቢት 2016'));
    });
  });

  group('Edge Cases', () {
    test('handles Ethiopian new year correctly', () {
      final gregorianNewYear = DateTime(2024, 9, 11); // Ethiopian New Year
      final ethiopianDate =
          EthiopianDateConverter.gregorianToEthiopian(gregorianNewYear);

      expect(ethiopianDate.year, equals(2017));
      expect(ethiopianDate.month, equals(1));
      expect(ethiopianDate.day, equals(1));
    });

    test('handles date before Ethiopian new year', () {
      final gregorianDate = DateTime(2024, 9, 10);
      final ethiopianDate =
          EthiopianDateConverter.gregorianToEthiopian(gregorianDate);

      expect(ethiopianDate.year, equals(2016));
      expect(ethiopianDate.month, equals(13));
      expect(ethiopianDate.day, equals(2));
    });

    test('handles last day of Pagume in leap year', () {
      final gregorianDate = DateTime(2024, 9, 10);
      final ethiopianDate =
          EthiopianDateConverter.gregorianToEthiopian(gregorianDate);

      expect(ethiopianDate.month, equals(13));
      expect(ethiopianDate.day, equals(2));
    });
  });

  group('Localization Tests', () {
    test('has correct number of Amharic months', () {
      expect(EthiopianLocalization.amharicMonths.length, equals(13));
    });

    test('has correct number of Amharic weekdays', () {
      expect(EthiopianLocalization.amharicDays.length, equals(7));
    });

    test('first month is Meskerem', () {
      expect(EthiopianLocalization.amharicMonths[0], equals('መስከረም'));
    });

    test('last month is Pagume', () {
      expect(EthiopianLocalization.amharicMonths[12], equals('ጳጉሜ'));
    });
  });
}
