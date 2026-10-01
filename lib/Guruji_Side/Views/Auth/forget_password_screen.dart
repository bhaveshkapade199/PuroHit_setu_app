import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_state.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/reset_password_screen.dart';

import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController forgetPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool _isBottomSheetShowing = false;

  @override
  void dispose() {
    forgetPasswordController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void _forgetPassword(BuildContext context) {
    final mobileNumber = forgetPasswordController.text.trim();

    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }

    if (mobileNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit mobile number'),
        ),
      );
      return;
    }

    context.read<ForgetPasswordBloc>().add(
      ForgetPasswordReqEvent(mobileNum: mobileNumber),
    );

    _showOtpBottomSheet(context);
  }

  String _maskPhoneNumber(String phone) {
    final number = phone.trim();
    if (number.length < 4) return number;
    final lastTwo = number.substring(number.length - 2);
    return "xxxxxx$lastTwo";
  }

  Future<void> _showOtpBottomSheet(BuildContext context) async {
    if (_isBottomSheetShowing) return;
    _isBottomSheetShowing = true;
    otpController.clear();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return _ForgetPasswordOtpSheet(
          otpController: otpController,
          maskedPhone: _maskPhoneNumber(forgetPasswordController.text),
          onVerify: (otp) {
            context.read<ForgetPasswordBloc>().add(
              VerifyForgetPasswordOtpEvent(otp),
            );
          },
          onResend: () {
            otpController.clear();
            context.read<ForgetPasswordBloc>().add(
              ResendForgetPasswordOtpEvent(),
            );
          },
        );
      },
    );

    _isBottomSheetShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        // OTP sent successfully → show OTP bottom sheet
        if (state is ForgetPasswordOtpSentState && !_isBottomSheetShowing) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message ?? 'OTP sent successfully'),
            ),
          );

          _showOtpBottomSheet(context);
        }

        // OTP verified → close bottom sheet & navigate to reset password
        if (state is ForgetPasswordOtpVerifiedState) {
          if (_isBottomSheetShowing) {
            Navigator.of(context).pop();
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ResetPasswordScreen(
                    verificationToken: state.verificationToken,
                    verificationUid: state.verificationUid,
                    mobileNum: state.mobileNum,
                  ),
                ),
              );
            }
          });
        }

        // Error → show snackbar
        if (state is ForgetPasswordErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        // OTP resent → show snackbar
        if (state is ForgetPasswordOtpResentState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP resent successfully')),
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
                      height: 300,
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
                    height: 400,
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

                // ==================================================
                // FORM CONTENT
                // ==================================================
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ==================================================
                              // TITLE
                              // ==================================================
                              const AppTitle(title: "Forget Password"),

                              SizedBox(height: isLandscape ? 18 : 32),

                              // ==================================================
                              // PHONE NUMBER
                              // ==================================================
                              FormTextField(
                                label: "Phone Number",
                                controller: forgetPasswordController,
                                keyboardType: TextInputType.phone,
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Color(0xFF00674f),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // ==================================================
                              // SEND OTP BUTTON
                              // ==================================================
                              BlocBuilder<
                                ForgetPasswordBloc,
                                ForgetPasswordState
                              >(
                                builder: (context, state) {
                                  final isLoading =
                                      state is ForgetPasswordLoadingState;

                                  return FamoElevatedButton(
                                    text: isLoading
                                        ? "Please Wait..."
                                        : "Send OTP",
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            _forgetPassword(context);
                                          },
                                  );
                                },
                              ),

                              SizedBox(height: isLandscape ? 20 : 36),

                              // ==================================================
                              // BACK TO LOGIN
                              // ==================================================
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_sharp,
                                      color: Color(0xff66110b),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Back to Login",
                                      style: TextStyle(
                                        color: Color(0xFF00674f),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
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
              ],
            );
          },
        ),
      ),
    );
  }
}
// ================================================================
// OTP Bottom Sheet Widget for Forget Password
// ================================================================

class _ForgetPasswordOtpSheet extends StatefulWidget {
  final TextEditingController otpController;
  final String maskedPhone;
  final ValueChanged<String> onVerify;
  final VoidCallback onResend;

  const _ForgetPasswordOtpSheet({
    required this.otpController,
    required this.maskedPhone,
    required this.onVerify,
    required this.onResend,
  });

  @override
  State<_ForgetPasswordOtpSheet> createState() =>
      _ForgetPasswordOtpSheetState();
}

class _ForgetPasswordOtpSheetState extends State<_ForgetPasswordOtpSheet> {
  Timer? _timer;
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 30;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    final isLandscape = mq.orientation == Orientation.landscape;
    final isTablet = size.width >= 600;
    final pinBoxWidth = ((size.width - 70) / 7).clamp(36.0, 48.0);
    final pinBoxHeight = isLandscape ? 42.0 : 50.0;

    return Padding(
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              isTablet ? 28 : 20,
              12,
              isTablet ? 28 : 20,
              isLandscape ? 12 : 20,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF00674f).withValues(alpha: 0.8),
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bottom sheet handle
                  Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: isLandscape ? 8 : 14),

                  // Icon
                  Icon(
                    Icons.lock_reset,
                    color: const Color(0xFFFFD700),
                    size: isLandscape ? 32 : 40,
                  ),
                  const SizedBox(height: 6),

                  // Title
                  Text(
                    "Verify Phone Number",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isLandscape ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle / Status feedback
                  BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                    builder: (context, state) {
                      if (state is ForgetPasswordLoadingState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Sending OTP to ${widget.maskedPhone}...",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is ForgetPasswordErrorState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }

                      return Text(
                        "OTP sent on the ${widget.maskedPhone} number",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: isLandscape ? 12 : 18),

                  // OTP Pin Input
                  Pinput(
                    length: 6,
                    controller: widget.otpController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onCompleted: (pin) {
                      widget.onVerify(pin);
                    },
                    defaultPinTheme: PinTheme(
                      width: pinBoxWidth,
                      height: pinBoxHeight,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: pinBoxWidth,
                      height: pinBoxHeight,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFFC107),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: isLandscape ? 12 : 18),

                  // Verify OTP Button
                  BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                    builder: (context, state) {
                      final isVerifying =
                          state is ForgetPasswordOtpVerifyingState;

                      return SizedBox(
                        width: double.infinity,
                        height: isLandscape ? 44 : 48,
                        child: FamoElevatedButton(
                          text: isVerifying ? "Verifying..." : "Verify OTP",
                          onPressed: isVerifying
                              ? null
                              : () {
                                  final otp = widget.otpController.text.trim();
                                  if (otp.length != 6) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please enter a valid 6-digit OTP",
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  widget.onVerify(otp);
                                },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // Timer / Resend OTP
                  if (_secondsRemaining > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Resend OTP in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    TextButton.icon(
                      onPressed: () {
                        widget.onResend();
                        _startTimer();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 16,
                        color: Color(0xFFFFD700),
                      ),
                      label: const Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: Color(0xFFFFD700),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
