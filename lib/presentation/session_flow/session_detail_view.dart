import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

// Adicione esta importação no seu cycle_drawer.dart:
// import 'package:structured_writing_protocol/presentation/session_detail_view.dart';

class SessionDetailView extends StatelessWidget {
  final String text;
  final int duration;
  final int number;
  final DateTime date;

  const SessionDetailView({
    super.key,
    required this.text,
    required this.duration,
    required this.number,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vanillaMonlight,
      appBar: AppBar(
        backgroundColor: AppColors.vanillaMonlight,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Sessão $number',
          style: const TextStyle(
            color: AppColors.velvetCharcoal,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.velvetCharcoal),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card com informações da sessão
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.toastedPeach,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoItem(
                        context,
                        Icons.calendar_today,
                        'Data',
                        _formatDate(date),
                      ),
                      _buildVerticalDivider(),
                      _buildInfoItem(
                        context,
                        Icons.access_time,
                        'Duração',
                        '$duration min',
                      ),
                      _buildVerticalDivider(),
                      _buildInfoItem(
                        context,
                        Icons.edit,
                        'Palavras',
                        '${_countWords(text)}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Título da seção de conteúdo
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.toastedPeach,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Conteúdo da Escrita',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.velvetCharcoal,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Container com o texto da sessão
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 200),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.mauveGray,
                  width: 1,
                ),
              ),
              child: text.trim().isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.edit_off,
                            size: 48,
                            color: AppColors.mauveGray,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Nenhum conteúdo foi escrito nesta sessão',
                            style: TextStyle(
                              color: AppColors.mauveGray,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: AppColors.velvetCharcoal,
                      ),
                    ),
            ),
            
            const SizedBox(height: 32),
            
            ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.toastedPeach,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.mauveGray,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.velvetCharcoal,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 60,
      color: AppColors.mauveGray,
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.mauveGray,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.velvetCharcoal,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  int _countWords(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }
}