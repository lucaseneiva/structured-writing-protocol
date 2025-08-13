import 'package:structured_writing_protocol/domain/entities/session.dart';
import 'package:hive/hive.dart';

part 'cycle.g.dart';

@HiveType(typeId: 0)
class Cycle {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final List<Session> sessions;

  @HiveField(2)
  final int completedSessions;

  @HiveField(3)
  final int totalSessions;

  @HiveField(4)
  final int sessionDuration;

  Cycle({
    required this.completedSessions,
    required this.totalSessions,
    required this.sessionDuration,
    required this.id,
    required this.sessions,
  });

  factory Cycle.empty() {
    return Cycle(
      id: '',
      sessions: [],
      completedSessions: 0,
      totalSessions: 0,
      sessionDuration: 0,
    );
  }

  factory Cycle.newCycle() {
    return Cycle(
      completedSessions: 0,
      totalSessions: 4,
      sessionDuration: 1,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sessions: [],
    );
  }

  bool get isActive => completedSessions < totalSessions;

  bool isEmpty() {
    return id == '' ? true : false;
  }
}
