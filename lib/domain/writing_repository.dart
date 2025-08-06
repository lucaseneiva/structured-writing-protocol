import 'package:structured_writing_protocol/domain/cycle.dart';
import 'package:structured_writing_protocol/domain/session.dart';

abstract class WritingRepository {
  Future<void> saveSession(String cycleId, Session session);

  Future<List<Cycle>> getAllCycles();

  Future<void> startNewCycle(Cycle cycle);  
}