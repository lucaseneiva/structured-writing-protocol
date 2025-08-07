import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class SessionsProgressCard extends StatelessWidget {
  final int totalNumberOfSessions;
  final int currentSession;

  const SessionsProgressCard({
    super.key,
    required this.totalNumberOfSessions,
    required this.currentSession,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(child: Text('Progresso')),
          SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2, // 3 por linha
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2.5,
            physics:
                const NeverScrollableScrollPhysics(), // impede scroll interno
            children: List.generate(totalNumberOfSessions, (index) {
              final sessionNumber = index + 1;
              final isCompleted = sessionNumber <= currentSession;

              return Center(
                child: Column(
                  children: [
                    Icon(
                      isCompleted ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                      size: 18,
                      color: isCompleted ? AppColors.velvetCharcoal : Colors.grey,
                    ),
                    Text(
                      'Sessão $sessionNumber',
                      style: TextStyle(
                        fontWeight: isCompleted
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isCompleted
                            ? AppColors.velvetCharcoal
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
