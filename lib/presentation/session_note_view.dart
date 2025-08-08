import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';
import 'dart:async';
import 'dart:math' as math;

class SessionNoteView extends StatefulWidget {
  final int sessionNumber;
  final String cycleName;
  final TextEditingController controller;

  const SessionNoteView({
    super.key,
    required this.sessionNumber,
    required this.cycleName,
    required this.controller,
  });

  @override
  State<SessionNoteView> createState() => _SessionNoteViewState();
}

class _SessionNoteViewState extends State<SessionNoteView>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();

  late AnimationController _pulseController;
  late Timer _timer;
  double elapsedSeconds = 0;
  final double totalDurationSeconds = 15 * 60; // 25 minutos

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapsedSeconds < totalDurationSeconds) {
        setState(() {
          elapsedSeconds++;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _pulseController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = elapsedSeconds / totalDurationSeconds;

    return Scaffold(
      backgroundColor: AppColors.vanillaMonlight,
      appBar: AppBar(
        backgroundColor: AppColors.vanillaMonlight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.velvetCharcoal),
        title: Text(
          "SESSÃO\n${widget.sessionNumber.toString().padLeft(2, '0')}",
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
                  "Ciclo ${widget.cycleName}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.velvetCharcoal,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, child) {
                    return Transform.scale(
                      scale: _pulseController.value,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Fundo: círculo colorido
                            const CircleAvatar(
                              backgroundColor: AppColors.toastedPeach,
                              radius: 16,
                            ),
                            // Frente: arco circular
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _PizzaPainter(progress),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
          color: Colors.transparent,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            maxLines: null,
            cursorColor: AppColors.velvetCharcoal,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: AppColors.velvetCharcoal,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Digite sua anotação...",
              hintStyle: TextStyle(color: Colors.grey),
              filled: false,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
class _PizzaPainter extends CustomPainter {
  final double progress;

  _PizzaPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final fullPaint = Paint()
      ..color = AppColors.toastedPeach
      ..style = PaintingStyle.fill;

    final missingPaint = Paint()
      ..color = AppColors.vanillaMonlight.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Desenha o círculo completo
    canvas.drawCircle(center, radius, fullPaint);

    // Calcula o ângulo da fatia "removida"
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * (1 - progress); // fatia restante

    // Desenha a fatia clara por cima
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, true, missingPaint);
  }

  @override
  bool shouldRepaint(covariant _PizzaPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
