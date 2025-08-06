import 'package:structured_writing_protocol/domain/session.dart';

class Cycle {
  final String id;
  final List<Session> sessions;

  Cycle({required this.id, required this.sessions});
}
