import 'package:flutter/material.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Center(
                  child: Image(
                    image: const AssetImage(
                      "Assets/Images/purohit-setu-logo.webp",
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 240,
              width: double.infinity,
              child: CustomPaint(
                painter: RPSCustomPainter(
                  fillColor: const Color(0xffcd9933).withValues(alpha: 0.5),
                  strokeColor: const Color.fromARGB(255, 255, 183, 0),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              child: Padding(
                padding: const EdgeInsets.only(top: 190),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
