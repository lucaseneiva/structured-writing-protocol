import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';
import 'package:structured_writing_protocol/providers.dart';
import 'package:structured_writing_protocol/presentation/session_flow/session_detail_view.dart';

class CycleDrawer extends ConsumerWidget {
  const CycleDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cycles = ref.watch(cycleListProvider);

    return Drawer(
      backgroundColor: AppColors.vanillaMonlight,
      child: Column(
        children: [
          AppBar(
            leading: const BackButton(),
            elevation: 0,
            backgroundColor: AppColors.vanillaMonlight,
            centerTitle: true,
            title: const Text(
              "Ciclos Passados",
              style: TextStyle(
                color: AppColors.velvetCharcoal,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            iconTheme: const IconThemeData(color: AppColors.velvetCharcoal),
          ),
          cycles.when(
            data: (cyclesList) => Expanded(
              child: ListView.builder(
                itemCount: cyclesList.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemBuilder: (context, index) {
                  final cycle = cyclesList[index];
                  final isLast = index == cyclesList.length - 1;

                  // --- CORREÇÃO PRINCIPAL: REMOVIDO O Expanded E O Padding EXTERNO ---
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ), // Apenas um espaçamento vertical
                    // --- MELHORIA 2: Adicionado o Theme para remover a borda ---
                    child: Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
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
                          isLast
                              ? "Ciclo ${index + 1} (Atual)"
                              : "Ciclo ${index + 1}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.velvetCharcoal,
                          ),
                        ),
                        children: cycle.sessions.map((session) {
                          return ListTile(
                            // --- MELHORIA 3: Usando contentPadding para alinhar ---
                            contentPadding: const EdgeInsets.only(
                              left: 24,
                              right: 16,
                            ),
                            title: Text(
                              "Sessão ${session.number}",
                              style: const TextStyle(
                                color: AppColors.velvetCharcoal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              "${session.date.day}/${session.date.month}/${session.date.year}",
                              style: TextStyle(
                                color: AppColors.velvetCharcoal.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            // --- MELHORIA 4 (BÔNUS): Exibindo a duração ---
                            trailing: Text(
                              '${session.duration} min',
                              style: const TextStyle(
                                color: AppColors.toastedPeach,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SessionDetailView(
                                    date: session.date,
                                    duration: session.duration,
                                    number: session.number,
                                    text: session.text,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar ciclos',
                    style: TextStyle(fontSize: 18, color: Colors.red.shade700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
