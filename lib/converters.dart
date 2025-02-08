import 'package:intl/intl.dart';

import 'ethiopian_date.dart';
import 'localization.dart';

class EthiopianDateConverter {
  static bool _isGregorianLeapYear(int year) {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  static EthiopianDate gregorianToEthiopian(DateTime date) {
    // Constants for Ethiopian calendar
    const int monthDays = 30;

    // Normalize the date to handle timezone differences
    final normalizedDate = DateTime(date.year, date.month, date.day);

    // Calculate the difference between Ethiopian and Gregorian calendars
    int yearDiff = 8;

    // Calculate initial Ethiopian date
    int year = normalizedDate.year - yearDiff;

    // Calculate days from Ethiopian New Year (September 11)
    int newYearDay = 11;
    DateTime ethiopianNewYear = DateTime(normalizedDate.year, 9, newYearDay);

    // If date is before Ethiopian New Year, adjust year
    if (normalizedDate.isBefore(ethiopianNewYear)) {
      year = normalizedDate.year - yearDiff;
    } else {
      year = normalizedDate.year - yearDiff + 1;
    }

    // Calculate the month and day
    int month;
    int day;

    // Month and day offset mapping for 2025 -> 2017
    final monthOffsets = {
      1: {'month': 5, 'offset': -8}, // January -> Tir (24 -> 16)
      2: {'month': 6, 'offset': -8}, // February -> Yekatit
      3: {'month': 7, 'offset': -7}, // March -> Megabit
      4: {'month': 8, 'offset': -7}, // April -> Miyazia
      5: {'month': 9, 'offset': -7}, // May -> Ginbot
      6: {'month': 10, 'offset': -7}, // June -> Sene
      7: {'month': 11, 'offset': -7}, // July -> Hamle
      8: {'month': 12, 'offset': -8}, // August -> Nehase
      9: {'month': 13, 'offset': -8}, // Early September -> Pagume
      10: {'month': 2, 'offset': -10}, // October -> Tikimt
      11: {'month': 3, 'offset': -9}, // November -> Hidar
      12: {'month': 4, 'offset': -9}, // December -> Tahsas
    };

    if (normalizedDate.month == 9 && normalizedDate.day >= newYearDay) {
      // After Ethiopian New Year in September
      month = 1; // Meskerem
      day = normalizedDate.day - 10;
    } else {
      var monthData = monthOffsets[normalizedDate.month]!;
      month = monthData['month']!;
      day = normalizedDate.day + monthData['offset']!;
    }

    // Handle month overflow
    if (day > monthDays) {
      day -= monthDays;
      month++;
    }
    // Handle negative days
    if (day <= 0) {
      month--;
      day += monthDays;
    }

    // Handle Pagume
    if (month == 13) {
      int maxDays = _isGregorianLeapYear(year) ? 6 : 5;
      if (day > maxDays) {
        day = maxDays;
      }
    }

    return EthiopianDate(
      year: year,
      month: month,
      day: day,
    );
  }

  static int _ethiopianToJDN(int year, int month, int day) {
    return 1723856 + 365 * (year - 1) + (year ~/ 4) + 30 * (month - 1) + day;
  }

  static DateTime ethiopianToGregorian(int year, int month, int day) {
    int jdn = _ethiopianToJDN(year, month, day);
    return _jdnToGregorian(jdn);
  }

  static DateTime _jdnToGregorian(int jdn) {
    int l = jdn + 68569;
    int n = (4 * l) ~/ 146097;
    l = l - ((146097 * n + 3) ~/ 4);
    int i = (4000 * (l + 1)) ~/ 1461001;
    l = l - ((1461 * i) ~/ 4) + 31;
    int j = (80 * l) ~/ 2447;
    int day = l - ((2447 * j) ~/ 80);
    l = j ~/ 11;
    int month = j + 2 - (12 * l);
    int year = 100 * (n - 49) + i + l;

    return DateTime(year, month, day);
  }

  // ignore: unused_element
  static int _gregorianToJDN(int year, int month, int day) {
    if (month <= 2) {
      year -= 1;
      month += 12;
    }

    int a = year ~/ 100;
    int b = 2 - a + (a ~/ 4);

    return ((365.25 * (year + 4716)).floor() +
            (30.6001 * (month + 1)).floor() +
            day +
            b -
            1524.5)
        .floor();
  }
}

extension EthiopianDateFormat on DateFormat {
  String formatEthiopian(DateTime date) {
    final ethiopianDate = EthiopianDateConverter.gregorianToEthiopian(date);
    return '${ethiopianDate.day} ${EthiopianLocalization.amharicMonths[ethiopianDate.month - 1]} ${ethiopianDate.year}';
  }

  String formatEthiopianShort(DateTime date) {
    final ethiopianDate = EthiopianDateConverter.gregorianToEthiopian(date);
    return '${ethiopianDate.day}/${ethiopianDate.month}/${ethiopianDate.year}';
  }

  String getEthiopianWeekday(DateTime date) {
    return EthiopianLocalization.amharicDays[date.weekday % 7];
  }

  String formatEthiopianFull(DateTime date) {
    final ethiopianDate = EthiopianDateConverter.gregorianToEthiopian(date);
    return '${getEthiopianWeekday(date)}, ${ethiopianDate.day} ${EthiopianLocalization.amharicMonths[ethiopianDate.month - 1]} ${ethiopianDate.year}';
  }
}
