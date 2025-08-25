import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class SessionCard extends StatelessWidget {
  final int sessionNumber;
  final String? dateFormatted;
  final bool isNext;
  final VoidCallback? onPressed;
  final bool isCompleted;
  const SessionCard({
    super.key,
    this.dateFormatted,
    required this.sessionNumber,
    required this.isNext,
    required this.onPressed,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isNext ? AppColors.toastedPeach : AppColors.mauveGray;
    
    // O widget principal que será retornado
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
              if (dateFormatted != null)
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.mauveGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateFormatted!,
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
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.mauveGray,
                    ),
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

          // Direita - Botão (só aparece se 'isNext' for verdadeiro)
          isNext
              ? (isCompleted
                    ? ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.toastedPeach,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text("Iniciar"),
                      )
                    : Icon(Icons.check_circle, color: AppColors.toastedPeach))
              : const SizedBox.shrink(), // se não for "isNext"
        ],
      ),
    );

    // Se NÃO for a próxima sessão, envolve o card com InkWell para torná-lo clicável
    if (!isNext) {
      return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(
          12,
        ), // Para o efeito de splash seguir a borda
        child: cardContent,
      );
    }

    // Se for a próxima sessão, retorna o card como estava, sem o InkWell
    return cardContent;
  }
}
