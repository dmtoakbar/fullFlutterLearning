import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui'as ui;

class CustomPaintThird extends StatefulWidget {
  const CustomPaintThird({super.key});

  @override
  State<CustomPaintThird> createState() => _CustomPaintThirdState();
}

class _CustomPaintThirdState extends State<CustomPaintThird>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // keep looping
  }

  @override
  void dispose() {
    animationController.dispose(); // clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.grey.shade200,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: CustomPaintThirdGuide(
                    animationController: animationController
                  ),
                  size: const Size(300, 400),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPaintThirdGuide extends CustomPainter {
  CustomPaintThirdGuide({required AnimationController animationController})
      : _animationController = animationController,
        super(repaint: animationController);

  final AnimationController _animationController;

  @override
  void paint(Canvas canvas, Size size) {
    final paragraphStyle = ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 24,
      maxLines: 2,
      ellipsis: '...',
    );

    final textStyle = ui.TextStyle(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );

    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText('Hello Flutter Canvas!\nCustomPainter Rocks!');

    final constraints = ui.ParagraphConstraints(width: size.width);

    final paragraph = paragraphBuilder.build()
      ..layout(constraints);

    // Draw text at a position
    canvas.drawParagraph(paragraph, const Offset(20, 100));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

