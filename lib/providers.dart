import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structured_writing_protocol/data/fake_writing_repository_impl.dart'; // Importamos o FAKE
import 'package:structured_writing_protocol/domain/cycle.dart';
import 'package:structured_writing_protocol/domain/writing_repository.dart';
import 'package:collection/collection.dart';

final writingRepositoryProvider = Provider<WritingRepository>((ref) {
  return FakeWritingRepositoryImpl();
});

final cycleListProvider = StateNotifierProvider<CycleListNotifier, List<Cycle>>(
  (ref) {
    final repository = ref.watch(writingRepositoryProvider);
    return CycleListNotifier(repository);
  },
);

final activeCycleProvider = Provider<Cycle?>((ref) {
  final cycles = ref.watch(cycleListProvider);
  return cycles.firstWhereOrNull(
    (cycle) => cycle.isActive,
  );
});

class CycleListNotifier extends StateNotifier<List<Cycle>> {
  final WritingRepository _repository;

  CycleListNotifier(this._repository) : super([]) {
    // Carrega os ciclos iniciais quando o provider é criado.
    loadCycles();
  }

  Future<void> loadCycles() async {
    state = await _repository.getAllCycles();
  }

  Future<void> addNewCycle(int sessionDuration, int totalSessions) async {
    final newCycle = Cycle(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ID simples
      sessions: [],
      sessionDuration: sessionDuration,
      completedSessions: 0,
      totalSessions: totalSessions,
    );
    await _repository.startNewCycle(newCycle);
    // Recarrega a lista para a tela se atualizar.
    loadCycles();
  }
}
