import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class PreviousSessionsSection extends StatelessWidget {
  final List<int> sessionNumbers;
  final void Function(int session)? onSessionTap;

  const PreviousSessionsSection({
    super.key,
    required this.sessionNumbers,
    this.onSessionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.mauveGray, // mesma borda da outra sessão
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sessões anteriores',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.grey, thickness: 1, height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: sessionNumbers.map((session) {
              return GestureDetector(
                onTap: onSessionTap != null
                    ? () => onSessionTap!(session)
                    : null,
                child: Text(
                  'Sessão $session',
                  style: const TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    color: AppColors.velvetCharcoal, // estilo "link"
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
