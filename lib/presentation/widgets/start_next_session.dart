import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class StartNextSession extends StatelessWidget {
  final int nextSessionNumber;
  final int durationMinutes;
  final VoidCallback onStartNextSession;

  const StartNextSession({
    super.key,
    required this.nextSessionNumber,
    required this.onStartNextSession,
    required this.durationMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.toastedPeach, // Cor da borda esquerda
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sessão $nextSessionNumber',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          // Linha pontilhada
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 16,
            indent: 0,
            endIndent: 0,
            // Estilo pontilhado não é nativo, então faremos um truque abaixo
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                '$durationMinutes minutos',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Spacer(),
              ElevatedButton(onPressed: onStartNextSession, child: const Text('Iniciar')),
            ],
          ),
        ],
      ),
    );
  }
}
