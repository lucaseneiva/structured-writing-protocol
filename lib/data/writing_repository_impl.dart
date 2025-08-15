import 'package:structured_writing_protocol/data/writing_local_data_source.dart';
import 'package:structured_writing_protocol/domain/entities/cycle.dart';
import 'package:structured_writing_protocol/domain/entities/session.dart';
import 'package:structured_writing_protocol/domain/repositories/writing_repository.dart';

class WritingRepositoryImpl implements WritingRepository {
  final IWritingLocalDataSource localDataSource;

  WritingRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Cycle>> getAllCycles() {
    return localDataSource.getAllCycles();
  }

  @override
  Future<void> startNewCycle() async {
    final newCycle = Cycle.newCycle();

    await localDataSource.saveCycle(newCycle);
  }

  @override
  Future<void> saveSession(String cycleId, Session session) async {
    final allCycles = await localDataSource.getAllCycles();

    final cycleToUpdate = allCycles.firstWhere(
      (cycle) => cycle.id == cycleId,
      orElse: () => throw Exception("Cycle with id $cycleId not found"),
    );

    final updatedSessions = List<Session>.from(cycleToUpdate.sessions)
      ..add(session);

    final updatedCycle = cycleToUpdate.copyWith(
      sessions: updatedSessions,
      completedSessions: cycleToUpdate.completedSessions + 1,
    );

    await localDataSource.saveCycle(updatedCycle);
  }
}
