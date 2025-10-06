import 'package:flutter/material.dart';
import 'dart:math';

class MultiColorCircle extends StatelessWidget {
  const MultiColorCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200), // Canvas size
      painter: MultiColorCirclePainter(), // Attach custom painter
    );
  }
}

class MultiColorCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Find center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    // Circle radius
    final radius = 80.0;

    // Circle thickness (stroke width)
    final strokeWidth = 10.0;

    // List of colors for each section
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
    ];

    // Calculate how much angle each color section will take (equal parts)
    final sweepAngle = 2 * pi / colors.length;

    // Start from top (-pi/2 is 12 o’clock position)
    double startAngle = -pi / 2;

    // Loop through each color and draw an arc section
    for (var color in colors) {
      final paint = Paint()
        ..color = color // Set current color
        ..style = PaintingStyle.stroke // Draw as outline (not filled)
        ..strokeWidth = strokeWidth // Thickness of the circle
        ..strokeCap = StrokeCap.butt; // Flat edge (can use round if preferred)

      // Draw the arc segment
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), // Define circular area
        startAngle, // Starting angle
        sweepAngle, // Arc length in radians
        false, // False = not filled, just stroke
        paint, // Paint style and color
      );

      // Move start angle forward for next section
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false; // No need to repaint
}
