import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String title;

  const AppTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF00674f), // Golden
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


class SectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;
  final bool showButton;

  const SectionHeader({
    super.key,
    required this.title,
    this.buttonText = 'View All >',
    this.onPressed,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF5E382A),
              fontSize: 15.5,
            ),
          ),
        ),

        if (showButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Color(0xFF4A2418),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
