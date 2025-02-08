class EthiopianDate {
  final int year;
  final int month;
  final int day;

  EthiopianDate({
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  String toString() =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
