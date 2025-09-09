import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:math' as math;

class CustomPainSecond extends StatefulWidget {
  const CustomPainSecond({super.key});

  @override
  State<CustomPainSecond> createState() => _CustomPainSecondState();
}

class _CustomPainSecondState extends State<CustomPainSecond> {
  ValueNotifier<ui.Image?> imageNotifier = ValueNotifier<ui.Image?>(null);

  getImage() {
    NetworkImage networkImage = const NetworkImage(
      'https://thumbs.dreamstime.com/b/beautiful-summer-landscape-mountains-sunrise-32721267.jpg',
    );
    ImageStream imageStream = networkImage.resolve(ImageConfiguration.empty);
    ImageStreamListener imageStreamListener = ImageStreamListener((
      imageInfo,
      synchronousCall,
    ) {
      imageNotifier.value = imageInfo.image;
    });
    imageStream.addListener(imageStreamListener);
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.grey.shade300,
            child: CustomPaint(
              painter: MasterPainter(imageInfoNotifier: imageNotifier),
              size: Size(300, 400),
            ),
          ),
        ),
      ),
    );
  }
}

class MasterPainter extends CustomPainter {
  MasterPainter({required this.imageInfoNotifier})
    : super(repaint: imageInfoNotifier);

  final ValueNotifier<ui.Image?> imageInfoNotifier;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 4;
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    Offset center = Offset(size.width / 2, size.width / 2);
    // canvas.drawRect(Rect.fromCenter(center: center, width: 100, height: 200), paint);
    // canvas.drawRect(Rect.fromCircle(center: center, radius: 40), paint);
    // canvas.drawRect(Rect.fromLTWH(10, 10, 140, 240), paint);
    // canvas.drawRect(Rect.fromLTRB(10, 10, 100, 200), paint);
    // canvas.drawOval(Rect.fromLTRB(20, 20, 100, 200), paint);
    // canvas.drawOval(Rect.fromCircle(center: center, radius: size.width/2), paint);
    // draw rectangle with rounded corner
    Rect rect = Rect.fromLTRB(10, 20, 100, 200);
    // canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(16)), paint);
    // canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: Radius.circular(10)), paint);
    // canvas.drawRRect(RRect.fromRectXY(rect, 10, 35), paint);
    // ===================
    // Rect bigRect = Rect.fromLTRB(10, 20, 100, 200);
    // Rect smallRect = Rect.fromLTRB(20, 30, 100, 100);
    // RRect bigRRect = RRect.fromRectXY(bigRect, 75, 25);
    // RRect smallRRect = RRect.fromRectXY(smallRect, 75, 25);
    // canvas.drawDRRect(bigRRect, smallRRect, paint);
    //   ========================
    //   canvas.drawColor(Colors.indigo, BlendMode.src);
    //   ====================
    //   paint.shader = ui.Gradient.linear(Offset.zero, Offset(size.width, size.height), [
    //     Colors.green,
    //     Colors.yellow,
    //   ]);
    //   canvas.drawPaint(paint);
    //===========================
    // paint.shader = ui.Gradient.linear(Offset.zero, Offset(size.width, size.height), [
    //   Colors.green,
    //   Colors.yellow,
    // ]);
    // canvas.clipRect(Offset.zero & size);
    // canvas.drawPaint(paint);
    //============
    // final List<Offset> points = <Offset>[
    //   Offset.zero,
    //   Offset(size.width, 0),
    //   Offset(size.width/2, size.height/2)
    // ];
    // canvas.drawPoints(ui.PointMode.points, points, paint);
    //====================
    // final List<Offset> points = <Offset>[
    //   Offset.zero,
    //   Offset(size.width, 0),
    //   Offset(size.width/2, size.height/2),
    //   Offset.zero
    // ];
    // canvas.drawPoints(ui.PointMode.polygon, points, paint);
    //================
    // final  points = Float32List.fromList([
    //   0, 0,
    //   size.width, 0,
    //   size.width / 2, size.height / 2,
    //   0, 0,
    // ]);
    //
    // canvas.drawRawPoints(ui.PointMode.polygon, points as Float32List, paint);
    // ui.Image? image = imageInfoNotifier.value;
    // if(image != null) {
    //   canvas.drawImage(image, Offset.zero, paint);
    // }
    //=====================
    // ui.Image? image = imageInfoNotifier.value;
    // if(image != null) {
    //   Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    //   Rect imageRect = Offset.zero & imageSize;
    //   Rect canvasRect = Offset.zero & size;
    //
    //   canvas.drawImageRect(image, imageRect, canvasRect, paint);
    // }
    //===========================
    // Path path =
    //     Path()..addOval(
    //       Rect.fromCenter(
    //         center: Offset(size.width / 2, size.height / 2),
    //         width: size.width / 2,
    //         height: size.height / 2,
    //       ),
    //     );
    //
    // canvas.drawShadow(path, Colors.blue, 10, false);
    // canvas.drawPath(path, paint);
    ///===================

    // ui.Image? image = imageInfoNotifier.value;
    // if (image != null) {
    //   final transforms = [
    //     RSTransform.fromComponents(
    //       rotation: 0,
    //       scale: 1,
    //       anchorX: 0,
    //       anchorY: 0,
    //       translateX: 0,
    //       translateY: 0,
    //     ),
    //     RSTransform.fromComponents(
    //       rotation: 0,
    //       scale: 1,
    //       anchorX: 0,
    //       anchorY: 0,
    //       translateX: 100,
    //       translateY: 100,
    //     ),
    //     RSTransform.fromComponents(
    //       rotation: 0.28,
    //       scale: 1,
    //       anchorX: 10,
    //       anchorY: 0,
    //       translateX: 200,
    //       translateY: 300,
    //     ),
    //   ];
    //
    //   final rects = [
    //     const Rect.fromLTWH(0, 0, 100, 100),
    //     const Rect.fromLTWH(0, 0, 100, 100), // reuse same source rect
    //     const Rect.fromLTWH(0, 0, 100, 100),
    //   ];
    //
    //   final colors = [
    //     Colors.white.withOpacity(0.5),
    //     Colors.red.withOpacity(0.5),
    //     Colors.blue.withOpacity(0.5),
    //   ];
    //
    //   canvas.drawAtlas(
    //     image,
    //     transforms,
    //     rects,
    //     colors,
    //     BlendMode.srcOver,
    //     null,
    //     paint,
    //   );
    // }

    //====================================
    // Offset canvasCenter = Offset(size.width/2, size.height/2);
    // Rect rectCanvasSize = Offset.zero & size;
    // Rect rectWalfCanvasSize = Offset.zero & size/2;
    // Paint paintBlack = Paint()..color=Colors.black;
    // Paint paintBlue = Paint()..color=Colors.blue;
    //
    // // canvas.clipRect(rectWalfCanvasSize);
    // // canvas.clipRRect(RRect.fromRectAndRadius(rectWalfCanvasSize, Radius.circular(10)));
    // canvas.clipPath(Path()..addOval(rectWalfCanvasSize));
    //
    //
    // canvas.drawRect(rectCanvasSize, paintBlack);
    // canvas.drawPath(Path()..addOval(Rect.fromCenter(center: canvasCenter, width: 108, height: 100)), paintBlue);

    //=================================

    // canvas.drawRect(Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: 200, height: 200), Paint()..color=Colors.blue);
    // canvas.drawRect(Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: 100, height: 100), Paint()..color=Colors.orange.shade700);
    // // save layer method and restore method

    //============================
    // Path path = Path();
    // RRect rectwo = RRect.fromRectAndRadius(
    //   Rect.fromCenter(
    //     center: Offset(size.width / 2, size.height / 2),
    //     width: size.width / 2,
    //     height: size.height / 2,
    //   ),
    //   Radius.circular(16),
    // );
    // Rect rectThree = Rect.fromCircle(center: Offset(size.width/2, size.height/2), radius: 108,);
    // path.addRRect(rectwo);
    // path.arcToPoint(Offset(100, 300), radius: Radius.circular(10)); // path.relativeArchPoint
    // path.addArc(rectThree, 0, math.pi/2);
    // canvas.drawPath(path, paint);
    ///===================
    // Path path = Path();
    // path.moveTo(0, size.height/2);
    // path.conicTo(size.width/2, size.height, size.width, size.height/2, 2); // 1 for parabola, 2 // hyperbola, less than 1 for sphere
    // // path.lineTo(size.width/2, 0);
    // // path.relativeMoveTo(10, 0);
    // // path.relativeMoveTo(50, 0);

    // =====================
    // Path path = Path();
    // path.moveTo(0, size.height/2);
    // path.quadraticBezierTo(size.width/2, size.height, size.width, size.height/2);
    //
    // canvas.drawPath(path, paint);
    //========================
    // Path path = Path();
    //
    // path.addPolygon([
    //   Offset.zero,
    //   Offset(size.width/2, 0),
    //   Offset(size.width/2, size.height/2),
    //   Offset(size.width, size.height/2),
    //   Offset(size.width, size.height),
    // ], false);
    // ===================
    // Path path = Path();
    // path.lineTo(208, 244.6);
    // path.addRect(
    //   Rect.fromCenter(
    //     center: Offset.zero,
    //     width: size.width / 3,
    //     height: size.height / 3,
    //   ),
    // );
    // path.addOval(
    //   Rect.fromCircle(
    //     center: Offset(size.width / 2, size.height / 2),
    //     radius: size.width / 3,
    //   ),
    // );
    // List<ui.PathMetric> pathMatric = path.computeMetrics().toList();
    //
    // Path subPath = pathMatric.last.extractPath(18, 20);
    //
    // ui.Tangent? tanget = pathMatric.last.getTangentForOffset(50);
    // print('----------------------------${pathMatric.length}');
    // print('----------------------------${pathMatric.first.length}');
    // canvas.drawPath(path, paint);
    //=================
    // Path pathA = Path();
    // Rect recta = Rect.fromCenter(
    //   center: Offset(size.width / 2, size.height / 2),
    //   width: size.width / 2,
    //   height: size.height / 2,
    // );
    // pathA.addOval(recta);
    // canvas.drawPath(pathA, paint..color = Colors.red);
    //
    // Path pathB = Path();
    // Rect rectb = Rect.fromCenter(
    //   center: Offset(size.width / 2, size.height / 2),
    //   width: size.width / 2.1,
    //   height: size.height / 2.1,
    // );
    // pathB.reset();///
    // pathB.addOval(rectb);
    // Path transalatePath = pathB.shift(Offset(size.width/4, 8));
    // canvas.drawPath(transalatePath, paint..color = Colors.indigo);
    //==============================
    // Path path = Path();
    // path.addRect(Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: size.width/2, height: size.height/2));
    //
    // canvas.drawPath(path, paint..color=Colors.orange);
    //
    // Matrix4 matrixFormation = Matrix4.identity();
    // matrixFormation.rotateX(0.753);
    // Path transformPath = path.transform(matrixFormation.storage);
    // canvas.drawPath(transformPath, paint..color=Colors.blue);
    //
    // // colculate area
    // Rect area = path.getBounds();
    // path.extendWithPath(Path()..addRect(path.getBounds()), Offset.zero);
    // canvas.drawPath(path, paint);
  //   ===============

    // combine method check your
    //
    // paint.strokeCap = StrokeCap.round;
    // paint.strokeJoin = StrokeJoin.bevel;
    // paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 5);
    // Path path = Path();
    // path.addRect(Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: size.width/2, height: size.height/2));
    //
    // canvas.drawPath(path, paint..style=PaintingStyle.fill..color=Colors.blue);
    // invertcolor
    //image filter

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
