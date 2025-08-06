class WritingLocalDataSource {
  Future<void> saveCycle(Map<String, dynamic> cycleData) async {
    print("Salvando no banco de dados local: $cycleData");
    return Future.value();
  }

  Future<List<Map<String, dynamic>>> getAllCycles() {
    print("Buscando todos os ciclos do banco de dados local...");
    return Future.value([]);
  }
}
