import 'package:flutter/material.dart';

class FamoElevatedButton extends StatelessWidget {
  const FamoElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = 48,
    this.fontSize = 16,
  });

  final String text;
  final VoidCallback? onPressed;
  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: double.infinity,
        height: size,
        padding: const EdgeInsets.all(0.7), // Border thickness
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),

          // ✨ Outer border
          border: Border.all(
            color: const Color.fromARGB(
              255,
              251,
              251,
              251,
            ).withValues(alpha: 0.85),
            width: 1,
          ),

          // ✨ Golden glow
          boxShadow: [
            BoxShadow(
              color: const Color(0xff66110b).withValues(alpha: 0.55),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),

            // Dark depth
          ],
        ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),

            // ✨ Golden gradient
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff66110b), Color(0xff66110b)],
            ),
          ),

          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(30),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
