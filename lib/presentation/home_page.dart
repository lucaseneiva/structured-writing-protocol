import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structured_writing_protocol/providers.dart';
import 'package:structured_writing_protocol/presentation/widgets/circular_progress_text.dart';
import 'package:structured_writing_protocol/presentation/widgets/session_card.dart';
import 'package:structured_writing_protocol/presentation/widgets/cycle_drawer.dart';
import 'package:intl/intl.dart';
import 'package:structured_writing_protocol/presentation/widgets/confirmation_dialog.dart';
import 'package:structured_writing_protocol/presentation/session_view.dart';

// Usamos ConsumerWidget para poder "ouvir" os providers.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCycle = ref.watch(activeCycleProvider);

    if (activeCycle == null) {
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Ciclo Atual")),
        drawer: CycleDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Não há nenhum ciclo ativo no momento.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ConfirmationDialog(
                      title: "Novo Ciclo",
                      message: "Você quer iniciar um novo ciclo?",
                      
                      onConfirmation: () {
                        ref.read(writingRepositoryProvider).startNewCycle();
                        ref.invalidate(cycleListProvider);
                      },
                    ),
                  );
                },
                child: const Text("Criar novo ciclo"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Ciclo Atual")),
      drawer: CycleDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircularProgressText(
                  completed: activeCycle.completedSessions,
                  total: activeCycle.totalSessions,
                ),
              ),
              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (activeCycle.completedSessions <
                      activeCycle.totalSessions) ...[
                    const Text("Próxima Sessão"),
                    SessionCard(
                      sessionNumber: activeCycle.completedSessions + 1,
                      isNext: true,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SessionView(
                              sessionNumber: activeCycle.completedSessions + 1,
                              // Podemos melhorar isso depois
                              sessionDurationInMinutes:
                                  activeCycle.sessionDuration,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],

                  if (activeCycle.sessions.isNotEmpty) ...[
                    const Text("Sessões Anteriores"),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: activeCycle.sessions.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final session = entry.value;

                        return SessionCard(
                          sessionNumber: index + 1,
                          dateFormatted: _formatDate(session.date),
                          isNext: false,
                          onPressed: () => {
                            // Navegar para ver detalhes da sessão
                          },
                        );
                      }).toList(),
                    ),
                  ],

                  if (activeCycle.completedSessions >=
                      activeCycle.totalSessions) ...[
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.celebration,
                            color: Colors.green.shade600,
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Parabéns!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                          Text(
                            "Você completou todas as ${activeCycle.totalSessions} sessões deste ciclo!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.green.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
