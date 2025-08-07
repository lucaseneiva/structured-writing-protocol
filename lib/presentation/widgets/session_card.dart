import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';
class SessionCard extends StatelessWidget {
  final int sessionNumber;
  final String dateFormatted; // ex: "07 ago 2025"
  final bool isNext;
  final VoidCallback onPressed;

  const SessionCard({
    Key? key,
    required this.sessionNumber,
    required this.dateFormatted,
    required this.isNext,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isNext ? AppColors.toastedPeach : AppColors.mauveGray;

    return Container(
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
          // Esquerda
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sessão $sessionNumber",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.velvetCharcoal,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: AppColors.mauveGray),
                  const SizedBox(width: 4),
                  Text(
                    dateFormatted,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.mauveGray,
                    ),
                  ),
                ],
              ),
              if (isNext) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppColors.mauveGray),
                    const SizedBox(width: 4),
                    const Text(
                      "15 minutos",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.mauveGray,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),

          // Direita - Botão
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.toastedPeach,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text(isNext ? "Iniciar" : "Ver"),
          ),
        ],
      ),
    );
  }
}
