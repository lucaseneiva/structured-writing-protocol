import 'package:structured_writing_protocol/domain/cycle.dart';
import 'package:structured_writing_protocol/domain/session.dart';
import 'package:structured_writing_protocol/domain/writing_repository.dart';

class FakeWritingRepositoryImpl implements WritingRepository {
  
  final List<Cycle> _cycles = [];
  int _cycleIdCounter = 0;

  @override
  Future<List<Cycle>> getAllCycles() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simula uma pequena demora
    return List.from(_cycles);
  }

  @override
  Future<void> startNewCycle(Cycle cycle) async {
    // Adiciona o novo ciclo na nossa lista.
    await Future.delayed(const Duration(milliseconds: 100)); // Simula
    _cycles.add(cycle);
    print("Ciclo adicionado! Total de ciclos: ${_cycles.length}");
  }

  // Não vamos implementar essa por agora para manter simples.
  @override
  Future<void> saveSession(String cycleId, Session session) async {
    // Lógica para encontrar o ciclo e adicionar a sessão iria aqui.
  }
}