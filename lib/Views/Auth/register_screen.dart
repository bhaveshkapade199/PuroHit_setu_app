import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pinput/pinput.dart';

import 'package:purohitset_app/Bloc/Auth/register_bloc/register_bloc.dart';
import 'package:purohitset_app/Bloc/Auth/register_bloc/register_event.dart';
import 'package:purohitset_app/Bloc/Auth/register_bloc/register_state.dart';

import 'package:purohitset_app/Views/Auth/register_otp_screen.dart';
import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  // Text controllers
  final fullnameController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final alternatePhoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();
  final languagePreferenceController = TextEditingController();

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
            MaterialPageRoute(builder: (context) => const RegisterOtpScreen()),
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
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'Assets/Images/purohit-setu-logo.webp',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),

                    const AppTitle(title: "Register"),

                    const SizedBox(height: 30),

                    // First Name
                    FormTextField(
                      controller: fullnameController,
                      label: "Enter Full Name",
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "First name is required";
                        }
                        return null;
                      },
                    ),

                    // Gender
                    _buildDropdown(
                      label: "Select Gender",
                      icon: Icons.wc,
                      items: const ["Male", "Female", "Other"],
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    text: state.phoneVerified ? "✓" : "OTP",
                                    onPressed: state.phoneVerified
                                        ? null
                                        : () async {
                                            final phone =
                                                phoneController.text.trim();
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
                                            context.read<RegisterBloc>().add(
                                              SendPhoneOtpEvent(phone),
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
                                    WhatsappSameAsPhoneChangedEvent(isChecked),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: FormTextField(
                                    controller: emailController,
                                    label: "Enter Your Email",
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
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
                                    text: state.emailVerified ? "✓" : "OTP",
                                    onPressed: state.emailVerified
                                        ? null
                                        : () async {
                                            final email =
                                                emailController.text.trim();
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
                                            context.read<RegisterBloc>().add(
                                              SendEmailOtpEvent(email),
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
                      onChanged: (value) {
                        debugPrint("UI VEDA SHAKHA SELECTED = [$value]");

                        context.read<RegisterBloc>().add(
                          VedaShakhaChangedEvent(value ?? ""),
                        );
                      },
                    ),

                    SizedBox(height: 20),
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

                    FamoElevatedButton(
                      text: "Register",
                      onPressed: () {
                        _registerUser(context);
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    // =========================
    // Split Full Name
    // =========================

    final name = _splitFullName(fullnameController.text);

    final firstName = name['firstName'] ?? '';
    final middleName = name['middleName'] ?? '';
    final lastName = name['lastName'] ?? '';

    // =========================
    // Current BLoC State
    // =========================

    final state = context.read<RegisterBloc>().state;

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
    debugPrint("Language: ${languagePreferenceController.text}");
    debugPrint("======================================");

    // =========================
    // Send Event
    // =========================

    context.read<RegisterBloc>().add(
      RegisterUserEvent(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,

        gender: state.gender,
        religion: state.religion,
        sampraday: state.sampraday,
        vedaShakha: state.vedaShakha,

        dateOfBirth: dobController.text.trim(),
        phone: phoneController.text.trim(),
        alternatePhone: alternatePhoneController.text.trim(),
        whatsappNumber: whatsappController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        bio: bioController.text.trim(),
        qualification: qualificationController.text.trim(),

        experienceYears: int.tryParse(experienceController.text.trim()) ?? 0,

        languagePreference: languagePreferenceController.text.trim(),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white, fontSize: 16),
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
        return BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.phoneVerified) {
              Navigator.pop(bottomSheetContext);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 9, 7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
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

                    const SizedBox(height: 15),

                    const Icon(
                      Icons.phone_android,
                      color: Color(0xFFFFD700),
                      size: 42,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Verify Phone Number",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "OTP sent on the "
                      "${_maskPhoneNumber(phoneController.text)} number",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // OTP
                    Pinput(
                      length: 6,
                      controller: phoneOtpController,
                      keyboardType: TextInputType.number,
                      autofocus: true,

                      defaultPinTheme: PinTheme(
                        width: 45,
                        height: 50,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      focusedPinTheme: PinTheme(
                        width: 45,
                        height: 50,
                        textStyle: const TextStyle(
                          fontSize: 20,
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

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FamoElevatedButton(
                        text: "Verify OTP",
                        onPressed: () {
                          final otp = phoneOtpController.text.trim();

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

                          context.read<RegisterBloc>().add(
                            VerifyPhoneOtpEvent(
                              otp,
                              phoneController.text.trim(),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 5),

                    TextButton(
                      onPressed: () {
                        phoneOtpController.clear();

                        context.read<RegisterBloc>().add(
                          SendPhoneOtpEvent(phoneController.text.trim()),
                        );
                      },
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(color: Color(0xFFFFD700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
        return BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.emailVerified) {
              Navigator.pop(bottomSheetContext);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 9, 7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
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

                    const SizedBox(height: 15),

                    const Icon(
                      Icons.email_outlined,
                      color: Color(0xFFFFD700),
                      size: 42,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Verify Email Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "OTP sent on the "
                      "${_maskEmail(emailController.text)} address",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // OTP
                    Pinput(
                      length: 6,
                      controller: emailOtpController,
                      keyboardType: TextInputType.number,
                      autofocus: true,

                      defaultPinTheme: PinTheme(
                        width: 45,
                        height: 50,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      focusedPinTheme: PinTheme(
                        width: 45,
                        height: 50,
                        textStyle: const TextStyle(
                          fontSize: 20,
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

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FamoElevatedButton(
                        text: "Verify OTP",
                        onPressed: () {
                          final otp = emailOtpController.text.trim();

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

                          context.read<RegisterBloc>().add(
                            VerifyEmailOtpEvent(
                              otp,
                              emailController.text.trim(),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 5),

                    TextButton(
                      onPressed: () {
                        emailOtpController.clear();

                        context.read<RegisterBloc>().add(
                          SendEmailOtpEvent(emailController.text.trim()),
                        );
                      },
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(color: Color(0xFFFFD700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
