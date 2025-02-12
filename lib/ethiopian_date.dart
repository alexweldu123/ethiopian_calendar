/// Defines the Ethiopian date model and related utilities.
///
/// The Ethiopian calendar:
/// * Has 13 months
/// * Is 7-8 years behind the Gregorian calendar
/// * Has 30 days in each month (except the 13th month)
library ethiopian_date;

/// A class representing a date in the Ethiopian calendar.
///
/// This class holds the year, month, and day of an Ethiopian date
/// and provides a method to convert it to a string representation.
///
/// Example:
/// ```dart
/// final ethiopianDate = EthiopianDate(year: 2016, month: 7, day: 11);
/// print(ethiopianDate); // Output: 2016-07-11
/// ```
class EthiopianDate {
  /// The year of the Ethiopian date.
  final int year;

  /// The month of the Ethiopian date (1-13).
  final int month;

  /// The day of the Ethiopian date (1-30 or 1-5 for the 13th month).
  final int day;

  /// Creates an instance of [EthiopianDate].
  ///
  /// [year] - The Ethiopian year.
  /// [month] - The Ethiopian month.
  /// [day] - The Ethiopian day.
  EthiopianDate({
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  String toString() =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
