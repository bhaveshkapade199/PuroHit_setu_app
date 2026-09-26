import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ImageRippleAnimation extends StatelessWidget {
  final String image;
  final double imageSize;

  const ImageRippleAnimation({
    super.key,
    required this.image,
    this.imageSize = 220,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imageSize + 80,
      height: imageSize + 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // =========================
          // RIPPLE 1
          // =========================
          Container(
                width: imageSize + 20,
                height: imageSize + 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 123, 0),
                    width: 2,
                  ),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1.25, 1.25),
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
              )
              .fadeOut(begin: 0.6, duration: const Duration(seconds: 2)),

          // =========================
          // RIPPLE 2
          // =========================
          Container(
                width: imageSize + 20,
                height: imageSize + 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 123, 0),
                    width: 2,
                  ),
                ),
              )
              .animate(
                delay: const Duration(milliseconds: 650),
                onPlay: (controller) => controller.repeat(),
              )
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1.25, 1.25),
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
              )
              .fadeOut(begin: 0.5, duration: const Duration(seconds: 2)),

          // =========================
          // RIPPLE 3
          // =========================
          Container(
                width: imageSize + 10,
                height: imageSize + 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 126, 5),
                    width: 6,
                  ),
                ),
              )
              .animate(
                delay: const Duration(milliseconds: 1300),
                onPlay: (controller) => controller.repeat(),
              )
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1.25, 1.25),
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
              )
              .fadeOut(begin: 0.4, duration: const Duration(seconds: 2)),

          // =========================
          // SMALL BUBBLE - TOP
          // =========================

          // =========================
          // SMALL BUBBLE - LEFT
          // =========================

          // =========================
          // SMALL BUBBLE - BOTTOM
          // =========================

          // =========================
          // MAIN IMAGE
          // =========================
          Container(
            width: imageSize,
            height: imageSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_outlined,
                    size: 120,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
