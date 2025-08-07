import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class SessionNoteView extends StatelessWidget {
  final int sessionNumber;
  final String cycleName;
  final String content;
  final TextEditingController controller;

  const SessionNoteView({
    super.key,
    required this.sessionNumber,
    required this.cycleName,
    required this.content,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vanillaMonlight,
      appBar: AppBar(
        backgroundColor: AppColors.vanillaMonlight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.velvetCharcoal),
        title: Text(
          "SESSÃO\n${sessionNumber.toString().padLeft(2, '0')}",
          style: const TextStyle(
            color: AppColors.velvetCharcoal,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ciclo $cycleName",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.velvetCharcoal,
                  ),
                ),
                const Icon(
                  Icons.brightness_1,
                  size: 20,
                  color: AppColors.toastedPeach,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Escreva aqui...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(16),
            ),
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}

class _LinedPaperPainter extends CustomPainter {
  final double lineHeight;
  final double topPadding;
  _LinedPaperPainter({required this.topPadding, required this.lineHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.velvetCharcoal
      ..strokeWidth = 1;

    double y = lineHeight + topPadding; // começa na primeira linha útil
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += lineHeight;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LinedTextField extends StatelessWidget {
  final TextEditingController controller;

  const LinedTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: _LinedPaperPainter(lineHeight: 24, topPadding: 16),
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true, // isso é essencial pra preencher todo o espaço!
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5, // importante: isso deve combinar com o lineHeight
              fontStyle: FontStyle.italic,
              color: AppColors.velvetCharcoal,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              border: InputBorder.none,
              hintText: "Digite sua sessão aqui...",
              hintStyle: TextStyle(color: AppColors.mauveGray),
            ),
            cursorColor: AppColors.velvetCharcoal,
          ),
        );
      },
    );
  }
}
