import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structured_writing_protocol/data/fake_writing_repository_impl.dart';
import 'package:structured_writing_protocol/domain/entities/cycle.dart';
import 'package:structured_writing_protocol/domain/repositories/writing_repository.dart';
import 'package:collection/collection.dart';

final writingRepositoryProvider = Provider<WritingRepository>((ref) {
  return FakeWritingRepositoryImpl();
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

final startNewCycleProvider = FutureProvider((ref) async {
  final repository = ref.read(writingRepositoryProvider);
  
  await repository.startNewCycle();
  
  ref.invalidate(cycleListProvider);
});
