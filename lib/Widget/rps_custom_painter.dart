import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  final Color fillColor;
  final Color? strokeColor;

  RPSCustomPainter({
    required this.fillColor,
    this.strokeColor = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * -0.0028571);
    path.quadraticBezierTo(
      0,
      size.height * 0.2671429,
      0,
      size.height * 0.3571429,
    );
    path.quadraticBezierTo(
      size.width * -0.0002250,
      size.height * 0.6786000,
      size.width * 0.2500000,
      size.height * 0.6714286,
    );
    path.lineTo(size.width * 0.7491667, size.height * 0.6785714);
    path.quadraticBezierTo(
      size.width * 1.0004417,
      size.height * 0.6648571,
      size.width,
      size.height * 0.9985714,
    );
    path.quadraticBezierTo(
      size.width * 1.0002083,
      size.height * 0.7492857,
      size.width * 1.0008333,
      size.height * 0.0014286,
    );
    path.lineTo(0, size.height * -0.0028571);
    path.close();

    canvas.drawPath(path, paintFill);

    if (strokeColor != null) {
      final paintStroke = Paint()
        ..color = strokeColor!
        ..style = PaintingStyle.stroke;

      canvas.drawPath(path, paintStroke);
    }
  }

  @override
  bool shouldRepaint(covariant RPSCustomPainter oldDelegate) {
    return oldDelegate.fillColor != fillColor ||
        oldDelegate.strokeColor != strokeColor;
  }
}

class MyTestClipShaper extends StatefulWidget {
  const MyTestClipShaper({super.key});

  @override
  State<MyTestClipShaper> createState() => _MyTestClipShaperState();
}

class _MyTestClipShaperState extends State<MyTestClipShaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                (MediaQuery.of(context).size.width * 0.5833333333333334)
                    .toDouble(),
              ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(
                fillColor: Colors.red,
                strokeColor: Colors.blue,
              ),
            ),
          ),
          const Expanded(child: Center(child: Text("Clipper Test Screen"))),
        ],
      ),
    );
  }
}
