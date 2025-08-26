import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structured_writing_protocol/data/writing_local_data_source.dart';
import 'package:structured_writing_protocol/data/writing_repository_impl.dart';
import 'package:structured_writing_protocol/domain/entities/cycle.dart';
import 'package:structured_writing_protocol/domain/repositories/writing_repository.dart';
import 'package:collection/collection.dart';


final localDataSourceProvider = Provider<IWritingLocalDataSource>((ref) {
  return WritingLocalDataSource();
});


final writingRepositoryProvider = Provider<WritingRepository>((ref) {
  // Pega o data source do provider
  final dataSource = ref.read(localDataSourceProvider);
  // E o injeta no nosso repositório real
  return WritingRepositoryImpl(localDataSource: dataSource); 
  
  // Adeus, FakeWritingRepositoryImpl!
  // return FakeWritingRepositoryImpl(); 
});


final cycleListProvider = FutureProvider<List<Cycle>>((ref) async {
  final repository = ref.read(writingRepositoryProvider);
  return await repository.getAllCycles();
});

final activeCycleProvider = Provider<Cycle?>((ref) {
  final cyclesAsync = ref.watch(cycleListProvider);
  
  return cyclesAsync.whenOrNull(
    data: (cycles) => cycles.firstWhereOrNull((cycle) => cycle.isActive),
  );
});

final currentDateProvider = StateProvider<DateTime>((ref) => DateTime.now());