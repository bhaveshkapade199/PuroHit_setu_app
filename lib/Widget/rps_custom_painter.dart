import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  final Color fillColor;
  final Color? strokeColor;
  final ImageProvider? backgroundImage;

  RPSCustomPainter({
    required this.fillColor,
    this.strokeColor = Colors.transparent,
    this.backgroundImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
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

    // Draw background color.
    canvas.drawPath(
      path,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill,
    );

    // Draw image inside the custom shape.
    if (backgroundImage != null) {
      final imageRect = Offset.zero & size;

      final imagePaint = Paint()
        ..shader = ImageShader(
          _image!,
          TileMode.clamp,
          TileMode.clamp,
          Matrix4.identity().storage,
        );

      canvas.save();
      canvas.clipPath(path);
      canvas.drawRect(imageRect, imagePaint);
      canvas.restore();
    }

    // Draw border.
    if (strokeColor != null && strokeColor != Colors.transparent) {
      canvas.drawPath(
        path,
        Paint()
          ..color = strokeColor!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  ui.Image? _image;

  @override
  bool shouldRepaint(covariant RPSCustomPainter oldDelegate) {
    return oldDelegate.fillColor != fillColor ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.backgroundImage != backgroundImage;
  }
}




class RPSCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
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
    path.lineTo(
      size.width * 0.7491667,
      size.height * 0.6785714,
    );
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

    return path;
  }

  @override
  bool shouldReclip(covariant RPSCustomClipper oldClipper) {
    return false;
  }
}
