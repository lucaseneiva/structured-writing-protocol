import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart'; // Nosso arquivo de providers
import 'package:structured_writing_protocol/presentation/widgets/sessions_progress_card.dart';

// Usamos ConsumerWidget para poder "ouvir" os providers.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // "ref.watch" ouve o provider. A tela vai reconstruir quando a lista de ciclos mudar.
    final cycles = ref.watch(cycleListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ciclo Atual"),
      
      ),
      drawer: Drawer(
        child: Column( // Adicionado para estrutura
          children: [
            // Você pode adicionar outros widgets aqui se quiser
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total de ciclos: ${cycles.length}", style: Theme.of(context).textTheme.headlineSmall),
            ),
            Expanded( // <-- A MÁGICA ACONTECE AQUI
              child: ListView.builder(
                itemCount: cycles.length,
                itemBuilder: (context, index) {
                  final cycle = cycles[index];
                  return ListTile(
                    title: Text("Ciclo #${index + 1}"), // Título mais claro  
                    trailing: Text("${cycle.sessions.length} / 5 sessões"), // Mostra o progresso
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(children: [SessionsProgressCard(totalNumberOfSessions: 4, currentSession: 1)],),
    );
  }
}