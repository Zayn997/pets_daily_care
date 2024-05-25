import 'daily_care_record.dart';

class Pet {
  final String name;
  final String type; // e.g., Cat or Dog
  final DateTime birthDate;
  final List<DailyCareRecord> careRecords;

  Pet({
    required this.name,
    required this.type,
    required this.birthDate,
    this.careRecords = const [],
  });
}
