import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_state.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/login_screen.dart';
import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';

class ResetPasswordScreen extends StatefulWidget {
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
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<ForgetPasswordBloc>().add(
      ResetPasswordSubmitEvent(
        phone: widget.mobileNum ?? '',
        verificationUid: widget.verificationUid ?? '',
        verificationToken: widget.verificationToken,
        newPassword: _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      ),
    );
  }

  Future<void> _showSuccessAndNavigate(
    BuildContext context,
    String message,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFF1B5E20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.greenAccent,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password Reset!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FamoElevatedButton(
                text: 'Go to Login',
                onPressed: () {
                  Navigator.of(context).pop(); // close dialog
                },
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );

    // After dialog is dismissed → navigate to Login, clear all routes
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          _showSuccessAndNavigate(context, state.message);
        }
        if (state is ResetPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // ==================================================
                // LOGO SECTION
                // ==================================================
                Column(
                  children: [
                    SizedBox(
                      height: 270,
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

                // ==================================================
                // CUSTOM PAINTER / BACKGROUND
                // ==================================================
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 370,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: RPSCustomPainter(
                        fillColor: const Color(
                          0xffcd9933,
                        ).withValues(alpha: 0.5),
                        strokeColor: const Color(0xffffd873),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 280),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - 288,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: isLandscape ? 8 : 20),

                                // Title
                                const AppTitle(title: "Reset Password"),

                                // Subtitle
                                Text(
                                  widget.mobileNum != null
                                      ? 'Set a new password for your account\nlinked to ${widget.mobileNum}'
                                      : 'Set a new password for your account',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),

                                // New Password
                                FormTextField(
                                  label: "New Password",
                                  controller: _newPasswordController,
                                  obscureText: !_newPasswordVisible,
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Color(0xFF00674f),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _newPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xFF00674f),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _newPasswordVisible =
                                            !_newPasswordVisible;
                                      });
                                    },
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter a new password';
                                    }
                                    if (value.trim().length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                    return null;
                                  },
                                ),

                                // Confirm Password
                                FormTextField(
                                  label: "Confirm Password",
                                  controller: _confirmPasswordController,
                                  obscureText: !_confirmPasswordVisible,
                                  prefixIcon: const Icon(
                                    Icons.lock_reset,
                                    color: Color(0xFF00674f),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xFF00674f),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible =
                                            !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value.trim() !=
                                        _newPasswordController.text.trim()) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 4),

                                // Reset Button
                                BlocBuilder<
                                  ForgetPasswordBloc,
                                  ForgetPasswordState
                                >(
                                  builder: (context, state) {
                                    final isLoading =
                                        state is ResetPasswordLoadingState;
                                    return FamoElevatedButton(
                                      text: isLoading
                                          ? 'Resetting...'
                                          : 'Reset Password',
                                      onPressed: isLoading
                                          ? null
                                          : () => _submit(context),
                                    );
                                  },
                                ),

                                SizedBox(height: isLandscape ? 16 : 28),

                                // Back to Login
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_sharp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "Back to Login",
                                        style: TextStyle(
                                          color: Color(0xFF00674f),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: isLandscape ? 8 : 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
