import 'package:flutter/material.dart';
import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  TextEditingController ForgetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Image.asset(
                  'Assets/Images/purohit-setu-logo.webp',
                  width: 170,
                  height: 170,
                  fit: BoxFit.cover,
                ),
                AppTitle(title: "Forget Password"),

                SizedBox(height: 40),
                FormTextField(
                  label: "Email or Phone Number",
                  controller: ForgetPasswordController,
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FamoElevatedButton(
                    text: "Forget Password",
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_sharp, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "Back to Login",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
