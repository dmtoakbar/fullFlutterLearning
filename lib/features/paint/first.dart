import 'package:flutter/material.dart';

class CustomPainFirst extends StatelessWidget {
  const CustomPainFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.grey.shade300,
            child: CustomPaint(
               painter: MasterPainter(),
               size: Size(300, 400),
             ),
          ),
        ),
      ),
    );
  }
}


class MasterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 4;
    paint.color = Colors.black;
    // for draw line
    // canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
    // for draw circle
    // for only stroke
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width/2, size.width/2), 140, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
