import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class SessionCard extends StatelessWidget {
  final int sessionNumber;
  final String? dateFormatted;
  final bool isTodaysSession;
  final VoidCallback? onPressed;
  const SessionCard({
    super.key,
    this.dateFormatted,
    required this.sessionNumber,
    required this.isTodaysSession,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isTodaysSession ? AppColors.toastedPeach : AppColors.mauveGray;
    
    Widget cardContent = Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.vanillaMonlight,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Esquerda (conteúdo da sessão)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sessão $sessionNumber",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.velvetCharcoal,
                ),
              ),
              const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.mauveGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateFormatted != null? dateFormatted! : 'Hoje',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mauveGray,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );

  return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(
          12,
        ),
        child: cardContent,
      );
    }

}
