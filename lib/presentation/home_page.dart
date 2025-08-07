import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart'; // Nosso arquivo de providers
import 'package:structured_writing_protocol/presentation/widgets/sessions_progress_card.dart';
import 'package:structured_writing_protocol/presentation/widgets/start_next_session.dart';
import 'package:structured_writing_protocol/presentation/widgets/previous_sessions_section.dart';
import 'package:structured_writing_protocol/presentation/widgets/circular_progress_text.dart';
import 'package:structured_writing_protocol/presentation/widgets/session_card.dart';

// Usamos ConsumerWidget para poder "ouvir" os providers.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // "ref.watch" ouve o provider. A tela vai reconstruir quando a lista de ciclos mudar.
    final cycles = ref.watch(cycleListProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Ciclo Atual")),
      drawer: Drawer(
        child: Column(
          // Adicionado para estrutura
          children: [
            // Você pode adicionar outros widgets aqui se quiser
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total de ciclos: ${cycles.length}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              // <-- A MÁGICA ACONTECE AQUI
              child: ListView.builder(
                itemCount: cycles.length,
                itemBuilder: (context, index) {
                  final cycle = cycles[index];
                  return ListTile(
                    title: Text("Ciclo #${index + 1}"), // Título mais claro
                    trailing: Text(
                      "${cycle.sessions.length} / 5 sessões",
                    ), // Mostra o progresso
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Center(child: CircularProgressText(completed: 2, total: 5)),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Próxima Sessão"),
                SessionCard(
                  sessionNumber: 3,
                  dateFormatted: "07 ago 2025",
                  isNext: true,
                  onPressed: () => {},
                ),
            
                const SizedBox(height: 32),
            
                Text("Sessões Anteriores"),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SessionCard(
                      sessionNumber: 2,
                      dateFormatted: "05 ago 2025",
                      isNext: false,
                      onPressed: () => {},
                    ),
                    SessionCard(
                      sessionNumber: 1,
                      dateFormatted: "03 ago 2025",
                      isNext: false,
                      onPressed: () => {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
