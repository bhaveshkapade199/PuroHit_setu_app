import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pinput/pinput.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/Auth/register_bloc/register_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/register_bloc/register_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/register_bloc/register_state.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/login_screen.dart';


import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  // Text controllers
  final fullnameController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final phoneOtpController = TextEditingController();
  final emailOtpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          // You can show loader here.
        }

        if (state is RegisterLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration successful")),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }

        if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? "Registration failed"),
            ),
          );
        }
      },
      child: Scaffold(
        body: CommonBackground(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = MediaQuery.sizeOf(context);
                final isLandscape =
                    MediaQuery.orientationOf(context) == Orientation.landscape;
                final isTablet = size.width >= 600;
                final logoSize = isLandscape
                    ? (size.height * 0.24).clamp(80.0, 110.0)
                    : (size.height * 0.16).clamp(85.0, 150.0);

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet
                            ? 32
                            : (size.width < 360 ? 14 : 20),
                        vertical: isLandscape ? 12 : 20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: isLandscape ? 6 : 12),
                            Image.asset(
                              'Assets/Images/purohit-setu-logo.webp',
                              width: logoSize,
                              height: logoSize,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 6),
                            const AppTitle(title: "Register"),
                            SizedBox(height: isLandscape ? 16 : 28),

                            // Full Name
                            FormTextField(
                              controller: fullnameController,
                              label: "Enter Full Name",
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Full name is required";
                                }
                                final parts = value.trim().split(
                                  RegExp(r'\s+'),
                                );
                                if (parts.length < 2) {
                                  return "Please enter at least first and last name (e.g. Bhavesh Kapade)";
                                }
                                return null;
                              },
                            ),

                            // Gender
                            _buildDropdown(
                              label: "Select Gender",
                              icon: Icons.wc,
                              items: const ["Male", "Female", "Other"],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select Gender";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                debugPrint("UI GENDER SELECTED = [$value]");

                                context.read<RegisterBloc>().add(
                                  GenderChangedEvent(value ?? ""),
                                );
                              },
                            ),

                            const SizedBox(height: 20),

                            // Date of Birth
                            _buildDateField(context),

                            const SizedBox(height: 20),

                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: FormTextField(
                                            controller: phoneController,
                                            label: "Enter Phone Number",
                                            prefixIcon: const Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                            ),
                                            keyboardType: TextInputType.phone,
                                            readOnly: state.phoneVerified,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return "Phone Number is required";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        SizedBox(
                                          width: 80,
                                          height: 42,
                                          child: FamoElevatedButton(
                                            text: state.phoneVerified
                                                ? "✓"
                                                : "OTP",
                                            onPressed: state.phoneVerified
                                                ? null
                                                : () async {
                                                    final phone =
                                                        phoneController.text
                                                            .trim();
                                                    if (phone.isEmpty) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Please enter phone number first",
                                                          ),
                                                        ),
                                                      );
                                                      return;
                                                    }
                                                    if (phone.length < 10) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Please enter a valid 10-digit phone number",
                                                          ),
                                                        ),
                                                      );
                                                      return;
                                                    }

                                                    // First send OTP
                                                    context
                                                        .read<RegisterBloc>()
                                                        .add(
                                                          SendPhoneOtpEvent(
                                                            phone,
                                                          ),
                                                        );

                                                    // Open OTP bottom sheet
                                                    await _showPhoneOtpBottomSheet(
                                                      context,
                                                    );
                                                  },
                                          ),
                                        ),
                                      ],
                                    ),

                                    if (state.phoneVerified)
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.verified,
                                                color: Colors.greenAccent,
                                                size: 18,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Phone Verified",
                                                style: TextStyle(
                                                  color: Colors.greenAccent,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),

                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                    const Text(
                                      "Same as whattsApp number",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),

                                    SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: Checkbox(
                                        value: state.isWhatsappSameAsPhone,
                                        activeColor: const Color(0xFFFFD700),
                                        checkColor: Colors.black,
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                        onChanged: (value) {
                                          final isChecked = value ?? false;

                                          context.read<RegisterBloc>().add(
                                            WhatsappSameAsPhoneChangedEvent(
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
                                    ),
                                  ],
                                );
                              },
                            ),

                            const SizedBox(height: 10),

                            // WhatsApp
                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return FormTextField(
                                  controller: whatsappController,
                                  label: "Enter WhatsApp Number",
                                  prefixIcon: const Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                  ),
                                  keyboardType: TextInputType.phone,

                                  // Don't allow editing when same as phone
                                  readOnly: state.isWhatsappSameAsPhone,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "WhattsApp Number is required";
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),

                            // Email
                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: FormTextField(
                                            controller: emailController,
                                            label: "Enter Your Email",
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return "Email is required";
                                              }

                                              if (!RegExp(
                                                r'^[^@]+@[^@]+\.[^@]+',
                                              ).hasMatch(value.trim())) {
                                                return "Enter a valid email";
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        SizedBox(
                                          width: 80,
                                          height: 42,
                                          child: FamoElevatedButton(
                                            text: state.emailVerified
                                                ? "✓"
                                                : "OTP",
                                            onPressed: state.emailVerified
                                                ? null
                                                : () async {
                                                    final email =
                                                        emailController.text
                                                            .trim();
                                                    if (email.isEmpty) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Please enter email first",
                                                          ),
                                                        ),
                                                      );
                                                      return;
                                                    }
                                                    if (!RegExp(
                                                      r'^[^@]+@[^@]+\.[^@]+',
                                                    ).hasMatch(email)) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Please enter a valid email",
                                                          ),
                                                        ),
                                                      );
                                                      return;
                                                    }

                                                    // First send OTP
                                                    context
                                                        .read<RegisterBloc>()
                                                        .add(
                                                          SendEmailOtpEvent(
                                                            email,
                                                          ),
                                                        );

                                                    // Open OTP bottom sheet
                                                    await _showEmailOtpBottomSheet(
                                                      context,
                                                    );
                                                  },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (state.emailVerified)
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.verified,
                                                color: Colors.greenAccent,
                                                size: 18,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Email Verified",
                                                style: TextStyle(
                                                  color: Colors.greenAccent,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),

                            // Religion
                            _buildDropdown(
                              label: "Select Religion",
                              icon: Icons.temple_hindu,
                              items: const ["Hindu"],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select Religion";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                debugPrint("UI RELIGION SELECTED = [$value]");

                                context.read<RegisterBloc>().add(
                                  ReligionChangedEvent(value ?? ""),
                                );
                              },
                            ),

                            const SizedBox(height: 20),

                            // Sampraday
                            _buildDropdown(
                              label: "Select Sampraday",
                              icon: Icons.account_balance,
                              items: const [
                                "Smarta",
                                "Vaishnava",
                                "Shaiva",
                                "Shakta",
                                "Other",
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select Sampraday";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                debugPrint("UI SAMPRADAY SELECTED = [$value]");

                                context.read<RegisterBloc>().add(
                                  SampradayChangedEvent(value ?? ""),
                                );
                              },
                            ),

                            const SizedBox(height: 20),

                            // Veda Shakha
                            _buildDropdown(
                              label: "Select Veda Shakha",
                              icon: Icons.menu_book,
                              items: const [
                                "Krishna Yajurveda",
                                "Shukla Yajurveda",
                                "Rigveda",
                                "Samaveda",
                                "Atharvaveda",
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select Veda Shakha";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                debugPrint(
                                  "UI VEDA SHAKHA SELECTED = [$value]",
                                );

                                context.read<RegisterBloc>().add(
                                  VedaShakhaChangedEvent(value ?? ""),
                                );
                              },
                            ),

                            const SizedBox(height: 20),
                            // Password
                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return FormTextField(
                                  controller: passwordController,
                                  label: "Enter Password",
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  obscureText: !state.isPasswordVisible,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Password is required";
                                    }
                                    if (value.trim().length < 8) {
                                      return "Password must be at least 8 characters";
                                    }
                                    return null;
                                  },
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      state.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      context.read<RegisterBloc>().add(
                                        PasswordVisibilityEvent(
                                          !state.isPasswordVisible,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),

                            // Confirm Password
                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return FormTextField(
                                  controller: confirmPasswordController,
                                  label: "Enter Confirm Password",
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  obscureText: !state.isPasswordVisible,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Confirm Password is required";
                                    }
                                    if (value != passwordController.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      state.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      context.read<RegisterBloc>().add(
                                        PasswordVisibilityEvent(
                                          !state.isPasswordVisible,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 10),

                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                final isLoading = state is RegisterLoadingState;
                                return FamoElevatedButton(
                                  text: isLoading
                                      ? "Registering..."
                                      : "Register",
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          _registerUser(context);
                                        },
                                );
                              },
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields correctly"),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    final state = context.read<RegisterBloc>().state;

    // Check Phone OTP verification
    if (!state.phoneVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please verify your phone number via OTP first"),
          backgroundColor: Colors.deepOrange,
        ),
      );
      return;
    }

    // Check Email OTP verification
    if (!state.emailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please verify your email via OTP first"),
          backgroundColor: Colors.deepOrange,
        ),
      );
      return;
    }

    // =========================
    // Split Full Name
    // =========================

    final name = _splitFullName(fullnameController.text);

    final firstName = name['firstName'] ?? '';
    final middleName = name['middleName'] ?? '';
    final lastName = name['lastName'] ?? '';

    // Debug
    debugPrint("========== NAME VALUES ==========");
    debugPrint("Full Name: ${fullnameController.text}");
    debugPrint("First Name: $firstName");
    debugPrint("Middle Name: $middleName");
    debugPrint("Last Name: $lastName");

    debugPrint("========== SELECTED VALUES ==========");
    debugPrint("Gender: ${state.gender}");
    debugPrint("Religion: ${state.religion}");
    debugPrint("Sampraday: ${state.sampraday}");
    debugPrint("Veda Shakha: ${state.vedaShakha}");
    debugPrint("======================================");

    final whatsapp = state.isWhatsappSameAsPhone ||
            whatsappController.text.trim().isEmpty
        ? phoneController.text.trim()
        : whatsappController.text.trim();

    context.read<RegisterBloc>().add(
      RegisterUserEvent(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName.isNotEmpty ? lastName : firstName,

        gender: state.gender,
        religion: state.religion,
        sampraday: state.sampraday,
        vedaShakha: state.vedaShakha,

        dateOfBirth: dobController.text.trim(),
        phone: phoneController.text.trim(),
        whatsappNumber: whatsapp,
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amberAccent),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFFFE0BD), width: 0.9),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFFFD700), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
      iconEnabledColor: Colors.white,
      items: items.map((item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Date of Birth is required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Date of Birth",
        labelStyle: const TextStyle(color: Colors.amberAccent),
        prefixIcon: const Icon(Icons.calendar_month, color: Colors.white),
        suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFFFD95A), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
      onTap: () async {
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(1995),
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
        );

        if (selectedDate != null) {
          dobController.text =
              "${selectedDate.year.toString().padLeft(4, '0')}-"
              "${selectedDate.month.toString().padLeft(2, '0')}-"
              "${selectedDate.day.toString().padLeft(2, '0')}";
        }
      },
    );
  }

  String _maskPhoneNumber(String phone) {
    final number = phone.trim();

    if (number.length < 4) {
      return number;
    }

    final lastTwoDigits = number.substring(number.length - 2);

    return "xxxxxx$lastTwoDigits";
  }

  Map<String, String> _splitFullName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return {'firstName': parts[0], 'middleName': '', 'lastName': ''};
    }

    if (parts.length == 2) {
      return {'firstName': parts[0], 'middleName': '', 'lastName': parts[1]};
    }

    return {
      'firstName': parts.first,
      'middleName': parts.sublist(1, parts.length - 1).join(' '),
      'lastName': parts.last,
    };
  }

  Future<void> _showPhoneOtpBottomSheet(BuildContext context) async {
    phoneOtpController.clear();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return _OtpBottomSheetContent(
          title: "Verify Phone Number",
          subtitle:
              "OTP sent on the ${_maskPhoneNumber(phoneController.text)} number",
          icon: Icons.phone_android,
          controller: phoneOtpController,
          onVerify: (otp) {
            context.read<RegisterBloc>().add(
              VerifyPhoneOtpEvent(otp, phoneController.text.trim()),
            );
          },
          onResend: () {
            phoneOtpController.clear();
            context.read<RegisterBloc>().add(
              SendPhoneOtpEvent(phoneController.text.trim()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP resent to phone")),
            );
          },
          checkVerified: (state) => state.phoneVerified,
        );
      },
    );
  }

  String _maskEmail(String email) {
    final trimmed = email.trim();
    final atIndex = trimmed.indexOf('@');
    if (atIndex <= 2) {
      return trimmed;
    }
    final name = trimmed.substring(0, atIndex);
    final domain = trimmed.substring(atIndex);
    final visiblePart = name.substring(0, 2);
    return "$visiblePart****$domain";
  }

  Future<void> _showEmailOtpBottomSheet(BuildContext context) async {
    emailOtpController.clear();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return _OtpBottomSheetContent(
          title: "Verify Email Address",
          subtitle:
              "OTP sent on the ${_maskEmail(emailController.text)} address",
          icon: Icons.email_outlined,
          controller: emailOtpController,
          onVerify: (otp) {
            context.read<RegisterBloc>().add(
              VerifyEmailOtpEvent(otp, emailController.text.trim()),
            );
          },
          onResend: () {
            emailOtpController.clear();
            context.read<RegisterBloc>().add(
              SendEmailOtpEvent(emailController.text.trim()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP resent to email")),
            );
          },
          checkVerified: (state) => state.emailVerified,
        );
      },
    );
  }
}

class _OtpBottomSheetContent extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onVerify;
  final VoidCallback onResend;
  final bool Function(RegisterState) checkVerified;

  const _OtpBottomSheetContent({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.controller,
    required this.onVerify,
    required this.onResend,
    required this.checkVerified,
  });

  @override
  State<_OtpBottomSheetContent> createState() => _OtpBottomSheetContentState();
}

class _OtpBottomSheetContentState extends State<_OtpBottomSheetContent> {
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

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (widget.checkVerified(state)) {
          Navigator.pop(context);
        }
      },
      child: Padding(
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
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 9, 7),
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
                    Icon(
                      widget.icon,
                      color: const Color(0xFFFFD700),
                      size: isLandscape ? 32 : 40,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLandscape ? 18 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: isLandscape ? 12 : 18),
                    // OTP Pin input
                    Pinput(
                      length: 6,
                      controller: widget.controller,
                      keyboardType: TextInputType.number,
                      autofocus: true,
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
                    SizedBox(
                      width: double.infinity,
                      height: isLandscape ? 44 : 48,
                      child: FamoElevatedButton(
                        text: "Verify OTP",
                        onPressed: () {
                          final otp = widget.controller.text.trim();
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
                    ),
                    const SizedBox(height: 10),
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
      ),
    );
  }
}
