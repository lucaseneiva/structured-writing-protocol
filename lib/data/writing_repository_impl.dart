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
    // A lógica de negócio (criar um novo ciclo) mora no repositório.
    final newCycle = Cycle.newCycle(); // Parâmetros fixos por enquanto
    
    // A persistência é delegada ao data source.
    await localDataSource.saveCycle(newCycle);
  }

  @override
  Future<void> saveSession(String cycleId, Session session) async {
    // Lógica futura:
    // 1. Buscar todos os ciclos
    // 2. Encontrar o ciclo com o cycleId
    // 3. Adicionar a nova sessão à lista de sessões do ciclo
    // 4. Chamar localDataSource.saveCycle(cicloAtualizado)
    throw UnimplementedError(); // Deixamos assim por enquanto.
  }
}