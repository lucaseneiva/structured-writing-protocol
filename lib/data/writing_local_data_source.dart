import 'package:hive/hive.dart';
import 'package:structured_writing_protocol/domain/entities/cycle.dart';

const String _kCyclesBox = 'cyclesBox'; // Nome da nossa "tabela" de ciclos

// Adicionamos uma interface para facilitar os testes no futuro
abstract class IWritingLocalDataSource {
  Future<void> saveCycle(Cycle cycle);
  Future<List<Cycle>> getAllCycles();
}

class WritingLocalDataSource implements IWritingLocalDataSource {
  
  // Abrimos a "caixa" (box) onde os ciclos serão armazenados.
  Future<Box<Cycle>> _getCyclesBox() async {
    return await Hive.openBox<Cycle>(_kCyclesBox);
  }

  @override
  Future<void> saveCycle(Cycle cycle) async {
    final box = await _getCyclesBox();
    // Usamos o 'id' do ciclo como chave para fácil acesso e atualização.
    await box.put(cycle.id, cycle); 
    print("Ciclo ${cycle.id} salvo no banco de dados local.");
  }

  @override
  Future<List<Cycle>> getAllCycles() async {
    final box = await _getCyclesBox();
    print("Buscando todos os ciclos do banco de dados local...");
    // .values retorna todos os itens da box.
    return box.values.toList();
  }
}