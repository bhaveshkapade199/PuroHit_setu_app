import 'package:flutter/material.dart';
import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String? verificationToken;
  final String? verificationUid;
  final String? mobileNum;

  const ResetPasswordScreen({
    super.key,
    this.verificationToken,
    this.verificationUid,
    this.mobileNum,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    final isTablet = size.width >= 600;
    return Scaffold(
      body: CommonBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 24,
            vertical: isLandscape ? 12 : 24,
          ),
          child: Column(
            children: [
              SizedBox(height: 120),
              Image.asset(
                'Assets/Images/purohit-setu-logo.webp',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),

              FormTextField(
                label: "Enter the New Password",
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),

                obscureText: false,
              ),
              SizedBox(height: 10),
              FormTextField(
                label: "Confirm Password",
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),

                obscureText: false,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FamoElevatedButton(
                  text: "Reset Password",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
