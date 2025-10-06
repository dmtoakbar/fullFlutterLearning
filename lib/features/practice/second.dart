import 'package:flutter/material.dart';
import 'dart:math';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(300, 300),
                  painter: ACircleWithSmallCircleWithDifferentColors(_controller.value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ACircleWithSmallCircleWithDifferentColors extends CustomPainter {
  final double progress; // 0.0 → 1.0 (loop)
  ACircleWithSmallCircleWithDifferentColors(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final bigRadius = 50.0;
    final totalDots = 7;
    final baseDotRadius = 10.0;

    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    // Draw each dot around the circle
    for (int i = 0; i < totalDots; i++) {
      // Calculate angle (add rotation)
      final angle = (2 * pi / totalDots) * i + (2 * pi * progress);

      // Calculate dot position
      final dx = center.dx + bigRadius * cos(angle);
      final dy = center.dy + bigRadius * sin(angle);

      // Compute how far each dot is from the "leading" animation head
      final distanceFromHead = (i / totalDots - progress) % 1.0;

      // Make closer dots bigger and brighter
      final scale = 1.0 + 0.6 * exp(-distanceFromHead * 10);
      final opacity = 1.0 - distanceFromHead.clamp(0, 1.0);

      final paint = Paint()
        ..color = colors[i % colors.length].withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dx, dy), baseDotRadius * scale, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ACircleWithSmallCircleWithDifferentColors oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
