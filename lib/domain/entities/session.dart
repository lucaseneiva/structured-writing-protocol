import 'package:hive/hive.dart';

part 'session.g.dart';

@HiveType(typeId: 1)
class Session {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int duration;

  @HiveField(3)
  final int number;

  @HiveField(4)
  final DateTime date;

  Session({
    required this.id,
    required this.text,
    required this.duration,
    required this.number,
    required this.date,
  });
}
