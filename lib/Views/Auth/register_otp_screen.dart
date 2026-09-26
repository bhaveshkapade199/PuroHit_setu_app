import 'package:flutter/material.dart';
import 'package:purohitset_app/Widget/common_background.dart';

class RegisterOtpScreen extends StatelessWidget {
  const RegisterOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        child: Column(
          children: [
            
            Image.asset(
              'Assets/Images/purohit-setu-logo.webp',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),

            AppTitle(title: "OTP"),

            SizedBox(height: 20),
            // OtpBoxField(controllers: otpcontroller, focusNodes: otpFocusNodes),
          ],
        ),
      ),
    );
  }
}
