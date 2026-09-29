import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Bloc/Auth/Forget_password_bloc/forget_password_bloc.dart';
import 'package:purohitset_app/Bloc/Auth/Forget_password_bloc/forget_password_event.dart';
import 'package:purohitset_app/Bloc/Auth/Forget_password_bloc/forget_password_state.dart';

import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController forgetPasswordController =
      TextEditingController();

  void _forgetPassword(BuildContext context) {
    final mobileNumber = forgetPasswordController.text.trim();

    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }

    context.read<ForgetPasswordBloc>().add(
      ForgetPasswordReqEvent(mobileNum: mobileNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    final isTablet = size.width >= 600;

    final logoSize = isLandscape
        ? (size.height * 0.28).clamp(70.0, 130.0)
        : (size.height * 0.18).clamp(90.0, 170.0);

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message ?? 'OTP sent successfully'),
            ),
          );

          // इथे OTP screen वर navigate करू शकता.
        }

        if (state is ForgetPasswordErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: CommonBackground(
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32 : 24,
                    vertical: isLandscape ? 12 : 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: isLandscape ? 10 : 20),

                      Image.asset(
                        'Assets/Images/purohit-setu-logo.webp',
                        width: logoSize,
                        height: logoSize,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 8),

                      const AppTitle(title: "Forget Password"),

                      SizedBox(height: isLandscape ? 18 : 32),

                      FormTextField(
                        label: "Phone Number",
                        controller: forgetPasswordController,
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                        builder: (context, state) {
                          final isLoading = state is ForgetPasswordLoadingState;

                          return FamoElevatedButton(
                            text: isLoading
                                ? "Please Wait..."
                                : "Forget Password",
                            onPressed: isLoading
                                ? null
                                : () {
                                    _forgetPassword(context);
                                  },
                          );
                        },
                      ),

                      SizedBox(height: isLandscape ? 20 : 36),

                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_sharp, color: Colors.white),
                            SizedBox(width: 6),
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

                      SizedBox(height: isLandscape ? 10 : 20),
                    ],
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
