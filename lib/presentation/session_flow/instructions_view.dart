import 'package:flutter/material.dart';

class InstructionsView extends StatelessWidget {
  final VoidCallback onStartPressed;

  const InstructionsView({super.key, required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Instruções",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            "Escreva continuamente sobre o que vier à sua mente. Não se preocupe com gramática, estilo ou coerência. Apenas deixe as palavras fluírem.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onStartPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text("Iniciar Sessão"),
          ),
        ],
      ),
    );
  }
}