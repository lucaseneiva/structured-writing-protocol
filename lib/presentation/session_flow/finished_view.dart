import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class FinishedView extends StatelessWidget {
  final String text;
  final VoidCallback onSavePressed;

  const FinishedView({
    super.key,
    required this.text,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Sessão Concluída!",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.velvetCharcoal.withAlpha(127)),
              ),
              child: SingleChildScrollView(
                child: Text(text, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onSavePressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text("Salvar e Concluir"),
          )
        ],
      ),
    );
  }
}