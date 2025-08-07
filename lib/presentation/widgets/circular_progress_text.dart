import 'package:flutter/material.dart';
import 'dart:math';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class CircularProgressText extends StatelessWidget {
  final int completed;
  final int total;

  const CircularProgressText({
    Key? key,
    required this.completed,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = completed / total;

    return CustomPaint(
      painter: _CircleProgressPainter(progress),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            '$completed/$total',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;

  _CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..color = AppColors.lightToastedPeach
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final foregroundPaint = Paint()
      ..color = AppColors.toastedPeach
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // fundo
    canvas.drawCircle(center, radius, backgroundPaint);

    // progresso
    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // começa do topo
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
