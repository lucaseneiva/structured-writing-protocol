import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:structured_writing_protocol/providers.dart'; // Idealmente, os dados viriam daqui
import 'package:structured_writing_protocol/domain/cycle.dart';
// import 'package:structured_writing_protocol/domain/session.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

// --- MELHORIA 1: Mova a lista para fora do método build! ---
// Se a lista fica dentro do build, ela é recriada toda vez que o widget atualiza,
// o que é muito ruim para a performance.
final List<Cycle> hardcodedCycles = [
  // --- CICLO 1 (PASSADO) ---

];


class CycleDrawer extends ConsumerWidget {
  const CycleDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Agora você pode usar a lista aqui sem recriá-la
    final cycles = hardcodedCycles; 
    // Ou melhor ainda, com Riverpod: final cycles = ref.watch(cyclesProvider);

    return Scaffold(
      backgroundColor: AppColors.vanillaMonlight,
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: AppColors.vanillaMonlight,
        centerTitle: true, 
        title: const Text(
          "Ciclos Passados",
          style: TextStyle(color: AppColors.velvetCharcoal, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: AppColors.velvetCharcoal),
      ),
      body: ListView.builder(
        itemCount: cycles.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final cycle = cycles[index];
          final isLast = index == cycles.length - 1;

          // --- CORREÇÃO PRINCIPAL: REMOVIDO O Expanded E O Padding EXTERNO ---
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0), // Apenas um espaçamento vertical
            // --- MELHORIA 2: Adicionado o Theme para remover a borda ---
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Container(
                  width: 4,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.toastedPeach,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // tilePadding: EdgeInsets.zero, // Não é mais necessário com 'leading'
                title: Text(
                  isLast ? "Ciclo ${index + 1} (Atual)" : "Ciclo ${index + 1}",
                  style: const TextStyle(fontSize: 18, color: AppColors.velvetCharcoal),
                ),
                children: cycle.sessions.map((session) {
                  return ListTile(
                    // --- MELHORIA 3: Usando contentPadding para alinhar ---
                    contentPadding: const EdgeInsets.only(left: 24, right: 16),
                    title: Text(
                      "Sessão ${session.number}",
                      style: const TextStyle(color: AppColors.velvetCharcoal, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "${session.date.day}/${session.date.month}/${session.date.year}",
                      style: TextStyle(color: AppColors.velvetCharcoal.withOpacity(0.7)),
                    ),
                    // --- MELHORIA 4 (BÔNUS): Exibindo a duração ---
                    trailing: Text(
                      '${session.duration} min',
                      style: const TextStyle(color: AppColors.toastedPeach, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Abriu a sessão ${session.id} do ciclo ${cycle.id}"),
                        duration: const Duration(seconds: 1),
                      ));
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}