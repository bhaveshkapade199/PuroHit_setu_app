import 'package:flutter/material.dart';

class FamoElevatedButton extends StatelessWidget {
  const FamoElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = 48,
    this.fontSize = 16,

    // Optional colors
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.shadowColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final double size;
  final double fontSize;

  // Optional colors
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    // Default colors
    final Color buttonColor = backgroundColor ?? const Color(0xff66110b);

    final Color buttonTextColor = textColor ?? Colors.white;

    final Color buttonBorderColor =
        borderColor ??
        const Color.fromARGB(255, 251, 251, 251).withValues(alpha: 0.85);

    final Color buttonShadowColor =
        shadowColor ?? const Color(0xff66110b).withValues(alpha: 0.55);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: double.infinity,
        height: size,
        padding: const EdgeInsets.all(0.7),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),

          // Outer border
          border: Border.all(color: buttonBorderColor, width: 1),

          // Shadow
          boxShadow: [
            BoxShadow(
              color: buttonShadowColor,
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),

            // Button background
            color: buttonColor,
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
                        color: buttonTextColor,
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
