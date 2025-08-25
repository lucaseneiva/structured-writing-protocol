import 'package:structured_writing_protocol/domain/entities/cycle.dart';
import 'package:structured_writing_protocol/domain/entities/session.dart';
import 'package:structured_writing_protocol/domain/repositories/writing_repository.dart';

class FakeWritingRepositoryImpl implements WritingRepository {
  final List<Cycle> _cycles = [];

  @override
  Future<List<Cycle>> getAllCycles() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    ); // Simula uma pequena demora
    return List.from(_cycles);
  }

  @override
  Future<void> startNewCycle() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    _cycles.add(Cycle.newCycle("aaa"));
    print("Ciclo adicionado! Total de ciclos: ${_cycles.length}");
  }

  // Não vamos implementar essa por agora para manter simples.
  @override
  Future<void> saveSession(String cycleId, Session session) async {
    // Lógica para encontrar o ciclo e adicionar a sessão iria aqui.
  }
}
