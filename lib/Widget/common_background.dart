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
