class DailyCareRecord {
  final DateTime date;
  final bool fed;
  final bool exercised;
  final String healthStatus;

  DailyCareRecord({
    required this.date,
    this.fed = false,
    this.exercised = false,
    this.healthStatus = 'Normal',
  });
}
