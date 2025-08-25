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
  final int totalSessions;

  @HiveField(3)
  final int sessionDuration;

  Cycle({
    required this.totalSessions,
    required this.sessionDuration,
    required this.id,
    required this.sessions,
  });

  factory Cycle.empty() {
    return Cycle(id: '', sessions: [], totalSessions: 0, sessionDuration: 0);
  }

  factory Cycle.newCycle(String id) {
    return Cycle(
      totalSessions: 4,
      sessionDuration: 1,
      id: id,
      sessions: [],
    );
  }

  Cycle copyWith({
    String? id,
    List<Session>? sessions,
    int? totalSessions,
    int? sessionDuration,
  }) {
    return Cycle(
      id: id ?? this.id,
      sessions: sessions ?? this.sessions,
      totalSessions: totalSessions ?? this.totalSessions,
      sessionDuration: sessionDuration ?? this.sessionDuration,
    );
  }

  int get completedSessions => sessions.length;
  bool get isActive => completedSessions < totalSessions;

  bool isEmpty() => id.isEmpty;

  bool isDailySessionDone(DateTime? referenceDate) {
    DateTime targetDate = referenceDate ?? DateTime.now();
    return sessions.any((session) => _isSameDay(session.date, targetDate));
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
