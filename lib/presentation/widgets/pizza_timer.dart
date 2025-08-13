import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';
import 'dart:math' as math;

class PizzaTimer extends StatefulWidget {
  final double progress;

  const PizzaTimer({super.key, required this.progress});

  
  
  @override
  State<PizzaTimer> createState() => _PizzaTimerState();
}

class _PizzaTimerState extends State<PizzaTimer> with SingleTickerProviderStateMixin{

  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
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
                const CircleAvatar(
                  backgroundColor: AppColors.toastedPeach,
                  radius: 16,
                ),
                Positioned.fill(
                  child: CustomPaint(painter: _PizzaPainter(widget.progress)),
                ),
              ],
            ),
          ),
        );
      },
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
