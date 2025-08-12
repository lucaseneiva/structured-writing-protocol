import 'package:flutter/foundation.dart';
import 'package:structured_writing_protocol/domain/entities/session.dart';

class Cycle {
  final String id;
  final List<Session> sessions;
  final int completedSessions;
  final int totalSessions;
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
      sessionDuration: 15,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sessions: [],
    );
  }
  
  bool get isActive => completedSessions < totalSessions;

  bool isEmpty() {
    return id == '' ? true : false;
  }
}
