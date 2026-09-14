import 'package:flutter/material.dart';
import '../theme/colors.dart';

class LogoMark extends StatelessWidget {
  final double size;
  final double iconSize;
  final double radius;
  final bool elevated;

  const LogoMark({
    super.key,
    required this.size,
    required this.iconSize,
    required this.radius,
    this.elevated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: AppColors.green.withValues(alpha: 0.45),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ]
            : null,
      ),
      child: Center(
        child: CustomPaint(size: Size(iconSize, iconSize), painter: _ChecklistPainter()),
      ),
    );
  }
}

class _ChecklistPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.075
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.17, size.height * 0.12, size.width * 0.66, size.height * 0.76),
      Radius.circular(size.width * 0.12),
    );
    canvas.drawRRect(rect, strokePaint);

    final path = Path()
      ..moveTo(size.width * 0.35, size.height * 0.52)
      ..lineTo(size.width * 0.44, size.height * 0.61)
      ..lineTo(size.width * 0.65, size.height * 0.40);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
