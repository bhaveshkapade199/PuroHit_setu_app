import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/login_screen.dart';
import 'package:purohitset_app/Repository/Yajaman_Auth_Repo/yajaman_auth_repository.dart';
import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';
import 'package:purohitset_app/Yajaman_Side/Bloc/Auth/register_bloc/yajaman_register_bloc.dart';
import 'package:purohitset_app/Yajaman_Side/Bloc/Auth/register_bloc/yajaman_register_event.dart';
import 'package:purohitset_app/Yajaman_Side/Bloc/Auth/register_bloc/yajaman_register_state.dart';

class YajamanRegisterScreen extends StatefulWidget {
  const YajamanRegisterScreen({super.key});

  @override
  State<YajamanRegisterScreen> createState() => _YajamanRegisterScreenState();
}

class _YajamanRegisterScreenState extends State<YajamanRegisterScreen> {
  // Text controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneOtpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneOtpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => YajamanRegisterBloc(YajamanAuthRepository()),
      child: BlocConsumer<YajamanRegisterBloc, YajamanRegisterState>(
        listener: (context, state) {
          if (state is YajamanRegisterLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Yajaman registration successful! Please login."),
                backgroundColor: Color(0xFF00674F),
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }

          if (state is YajamanRegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Registration failed"),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // Top Logo
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

                    // Custom background painter
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 240,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: RPSCustomPainter(
                            fillColor: const Color(
                              0xffcd9933,
                            ).withValues(alpha: 0.5),
                            strokeColor: const Color.fromARGB(255, 255, 183, 0),
                          ),
                        ),
                      ),
                    ),

                    // Form Content
                    Positioned.fill(
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 170),
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
                                minHeight: constraints.maxHeight - 200,
                              ),
                              child: Column(
                                children: [
                                  const AppTitle(title: "Yajaman Register"),

                                  const SizedBox(height: 25),

                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // Full Name
                                        FormTextField(
                                          controller: nameController,
                                          label: "Enter Full Name *",
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Color(0xFF00674F),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Full name is required";
                                            }
                                            return null;
                                          },
                                        ),

                                        // Phone Number + OTP Verify
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: FormTextField(
                                                controller: phoneController,
                                                label: "Enter Phone Number *",
                                                prefixIcon: const Icon(
                                                  Icons.phone,
                                                  color: Color(0xFF00674F),
                                                ),
                                                keyboardType:
                                                    TextInputType.phone,
                                                readOnly: state.phoneVerified,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return "Phone number is required";
                                                  }
                                                  if (value.trim().length <
                                                      10) {
                                                    return "Enter a valid 10-digit phone number";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 80,
                                              height: 44,
                                              child: FamoElevatedButton(
                                                backgroundColor:
                                                    state.phoneVerified
                                                    ? const Color(0xFF00674F)
                                                    : const Color(0xff66110b),
                                                text: state.phoneVerified
                                                    ? "✓"
                                                    : "Verify",
                                                onPressed: state.phoneVerified
                                                    ? null
                                                    : () async {
                                                        final phone =
                                                            phoneController.text
                                                                .trim();
                                                        if (phone.isEmpty ||
                                                            phone.length < 10) {
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                "Please enter a valid 10-digit phone number first",
                                                              ),
                                                            ),
                                                          );
                                                          return;
                                                        }

                                                        context
                                                            .read<
                                                              YajamanRegisterBloc
                                                            >()
                                                            .add(
                                                              YajamanSendPhoneOtpEvent(
                                                                phone,
                                                              ),
                                                            );

                                                        await _showPhoneOtpBottomSheet(
                                                          context,
                                                        );
                                                      },
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Same as phone checkbox
                                        Row(
                                          children: [
                                            Checkbox(
                                              value:
                                                  state.isWhatsappSameAsPhone,
                                              activeColor: const Color(
                                                0xFF00674F,
                                              ),
                                              onChanged: (val) {
                                                final isChecked = val ?? false;
                                                context
                                                    .read<YajamanRegisterBloc>()
                                                    .add(
                                                      YajamanWhatsappSameAsPhoneChangedEvent(
                                                        isChecked,
                                                      ),
                                                    );
                                                if (isChecked) {
                                                  whatsappController.text =
                                                      phoneController.text;
                                                } else {
                                                  whatsappController.clear();
                                                }
                                              },
                                            ),
                                            const Text(
                                              "WhatsApp number is same as phone",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // WhatsApp Number
                                        FormTextField(
                                          controller: whatsappController,
                                          label: "Enter WhatsApp Number",
                                          prefixIcon: const Icon(
                                            Icons.chat,
                                            color: Color(0xFF00674F),
                                          ),
                                          keyboardType: TextInputType.phone,
                                          readOnly: state.isWhatsappSameAsPhone,
                                        ),

                                        // Email
                                        FormTextField(
                                          controller: emailController,
                                          label: "Enter Email (Optional)",
                                          prefixIcon: const Icon(
                                            Icons.email,
                                            color: Color(0xFF00674F),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value != null &&
                                                value.trim().isNotEmpty) {
                                              if (!RegExp(
                                                r'^[^@]+@[^@]+\.[^@]+',
                                              ).hasMatch(value.trim())) {
                                                return "Enter a valid email address";
                                              }
                                            }
                                            return null;
                                          },
                                        ),

                                        // City
                                        FormTextField(
                                          controller: cityController,
                                          label: "Enter City *",
                                          prefixIcon: const Icon(
                                            Icons.location_city,
                                            color: Color(0xFF00674F),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "City is required";
                                            }
                                            return null;
                                          },
                                        ),

                                        // Address
                                        FormTextField(
                                          controller: addressController,
                                          label: "Enter Address *",
                                          prefixIcon: const Icon(
                                            Icons.home,
                                            color: Color(0xFF00674F),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Address is required";
                                            }
                                            return null;
                                          },
                                        ),

                                        // Pincode
                                        FormTextField(
                                          controller: pincodeController,
                                          label: "Enter Pincode *",
                                          prefixIcon: const Icon(
                                            Icons.pin_drop,
                                            color: Color(0xFF00674F),
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Pincode is required";
                                            }
                                            return null;
                                          },
                                        ),

                                        // Password
                                        FormTextField(
                                          controller: passwordController,
                                          label: "Enter Password *",
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Color(0xFF00674F),
                                          ),
                                          obscureText: !state.isPasswordVisible,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Password is required";
                                            }
                                            if (value.trim().length < 6) {
                                              return "Password must be at least 6 characters";
                                            }
                                            return null;
                                          },
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              state.isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: const Color(0xFF00674F),
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<YajamanRegisterBloc>()
                                                  .add(
                                                    YajamanPasswordVisibilityEvent(
                                                      !state.isPasswordVisible,
                                                    ),
                                                  );
                                            },
                                          ),
                                        ),

                                        // Confirm Password
                                        FormTextField(
                                          controller: confirmPasswordController,
                                          label: "Enter Confirm Password *",
                                          prefixIcon: const Icon(
                                            Icons.lock_outline,
                                            color: Color(0xFF00674F),
                                          ),
                                          obscureText: !state.isPasswordVisible,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Confirm Password is required";
                                            }
                                            if (value !=
                                                passwordController.text) {
                                              return "Passwords do not match";
                                            }
                                            return null;
                                          },
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              state.isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: const Color(0xFF00674F),
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<YajamanRegisterBloc>()
                                                  .add(
                                                    YajamanPasswordVisibilityEvent(
                                                      !state.isPasswordVisible,
                                                    ),
                                                  );
                                            },
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        // Submit Button
                                        FamoElevatedButton(
                                          text:
                                              state
                                                  is YajamanRegisterLoadingState
                                              ? "Registering..."
                                              : "Register as Yajaman",
                                          onPressed:
                                              state
                                                  is YajamanRegisterLoadingState
                                              ? null
                                              : () => _submitForm(context),
                                        ),

                                        const SizedBox(height: 20),

                                        // Already have account -> Login
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Already have an account?",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                  vertical: 4,
                                                ),
                                                child: Text(
                                                  " Login",
                                                  style: TextStyle(
                                                    color: Color(0xFF00674F),
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 40),
                                      ],
                                    ),
                                  ),
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
          );
        },
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields correctly"),
        ),
      );
      return;
    }

    final whatsapp = whatsappController.text.trim().isNotEmpty
        ? whatsappController.text.trim()
        : phoneController.text.trim();

    context.read<YajamanRegisterBloc>().add(
      YajamanRegisterSubmitEvent(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        whatsappNumber: whatsapp,
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        pincode: pincodeController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  Future<void> _showPhoneOtpBottomSheet(BuildContext context) async {
    phoneOtpController.clear();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return _YajamanOtpBottomSheet(
          phone: phoneController.text.trim(),
          controller: phoneOtpController,
          onVerify: (otp) {
            context.read<YajamanRegisterBloc>().add(
              YajamanVerifyPhoneOtpEvent(otp, phoneController.text.trim()),
            );
          },
          onResend: () {
            phoneOtpController.clear();
            context.read<YajamanRegisterBloc>().add(
              YajamanSendPhoneOtpEvent(phoneController.text.trim()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP resent to phone")),
            );
          },
        );
      },
    );
  }
}

class _YajamanOtpBottomSheet extends StatefulWidget {
  final String phone;
  final TextEditingController controller;
  final ValueChanged<String> onVerify;
  final VoidCallback onResend;

  const _YajamanOtpBottomSheet({
    required this.phone,
    required this.controller,
    required this.onVerify,
    required this.onResend,
  });

  @override
  State<_YajamanOtpBottomSheet> createState() => _YajamanOtpBottomSheetState();
}

class _YajamanOtpBottomSheetState extends State<_YajamanOtpBottomSheet> {
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
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Icon(Icons.phone_android, color: Color(0xFF00674F), size: 40),
          const SizedBox(height: 8),
          const Text(
            "Verify Phone Number",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Enter OTP sent to ${widget.phone}",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          Pinput(
            controller: widget.controller,
            length: 6,
            defaultPinTheme: PinTheme(
              width: 45,
              height: 48,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF00674F)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FamoElevatedButton(
            text: "Verify OTP",
            onPressed: () {
              if (widget.controller.text.trim().length >= 4) {
                widget.onVerify(widget.controller.text.trim());
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _secondsRemaining == 0
                ? () {
                    widget.onResend();
                    _startTimer();
                  }
                : null,
            child: Text(
              _secondsRemaining > 0
                  ? "Resend OTP in ${_secondsRemaining}s"
                  : "Resend OTP",
              style: TextStyle(
                color: _secondsRemaining == 0
                    ? const Color(0xFF00674F)
                    : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
