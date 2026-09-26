import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
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
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
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
                      controller: firstNameController,
                      label: "Enter First Name",
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "First name is required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    // Middle Name
                    FormTextField(
                      controller: middleNameController,
                      label: "Enter Middle Name",
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Middle name is required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    // Last Name
                    FormTextField(
                      controller: lastNameController,
                      label: "Enter Last Name",
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Last name is required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

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
                                            // First send OTP
                                            context.read<RegisterBloc>().add(
                                              const SendPhoneOtpEvent(),
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
                              "Same as phone number",
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

                    // Alternate Phone
                    FormTextField(
                      controller: alternatePhoneController,
                      label: "Enter Alternate Phone Number",
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.phone,
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

                    const SizedBox(height: 10),

                    // Email
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
                              if (value == null || value.trim().isEmpty) {
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
                        SizedBox(width: 5),
                        SizedBox(
                          width: 80,
                          height: 42,
                          child: FamoElevatedButton(
                            text: "OTP",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

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
                    const SizedBox(height: 10),

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

                    // Bio
                    FormTextField(
                      controller: bioController,
                      label: "Enter Your Bio",
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.white,
                      ),
                      maxLines: 4,
                    ),

                    const SizedBox(height: 10),

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

                    const SizedBox(height: 20),

                    // Qualification
                    FormTextField(
                      controller: qualificationController,
                      label: "Enter Qualification",
                      prefixIcon: const Icon(Icons.school, color: Colors.white),
                    ),

                    const SizedBox(height: 10),

                    // Experience
                    FormTextField(
                      controller: experienceController,
                      label: "Experience in Years",
                      prefixIcon: const Icon(
                        Icons.work_history,
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 10),

                    // Language
                    // FormTextField(
                    //   controller: languagePreferenceController,
                    //   label: "Language Preference",
                    //   prefixIcon: const Icon(
                    //     Icons.language,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    MultiDropdown<String>(
                      items: [
                        DropdownItem(label: 'Marathi', value: 'mr'),
                        DropdownItem(label: 'Hindi', value: 'hi'),
                        DropdownItem(label: 'Sanskrit', value: 'sa'),
                        DropdownItem(label: 'English', value: 'en'),
                        DropdownItem(label: 'Gujarati', value: 'gu'),
                      ],

                      fieldDecoration: FieldDecoration(
                        labelText: 'Language Preference',
                        labelStyle: const TextStyle(color: Colors.amberAccent),
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFFFE0BD),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFFFD700),
                          ),
                        ),
                      ),

                      dropdownDecoration: DropdownDecoration(
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                      ),

                      chipDecoration: const ChipDecoration(
                        backgroundColor: Color(0xFFD8AF49),
                        labelStyle: TextStyle(color: Colors.white),
                      ),

                      onSelectionChange: (selectedItems) {
                        if (selectedItems.isNotEmpty) {
                          languagePreferenceController.text = selectedItems
                              .join(',');
                        } else {
                          languagePreferenceController.clear();
                        }

                        debugPrint(
                          "Selected Languages: ${languagePreferenceController.text}",
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    FamoElevatedButton(
                      text: "Register",
                      onPressed: () {
                        _registerUser(context);
                      },
                    ),

                    const SizedBox(height: 30),
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
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    final state = context.read<RegisterBloc>().state;

    debugPrint("========== SELECTED VALUES ==========");
    debugPrint("Gender: ${state.gender}");
    debugPrint("Religion: ${state.religion}");
    debugPrint("Sampraday: ${state.sampraday}");
    debugPrint("Veda Shakha: ${state.vedaShakha}");
    debugPrint("Language: ${languagePreferenceController.text}");
    debugPrint("======================================");

    context.read<RegisterBloc>().add(
      RegisterUserEvent(
        firstName: firstNameController.text.trim(),
        middleName: middleNameController.text.trim(),
        lastName: lastNameController.text.trim(),

        // IMPORTANT
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
                            VerifyPhoneOtpEvent(otp),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 5),

                    TextButton(
                      onPressed: () {
                        phoneOtpController.clear();

                        context.read<RegisterBloc>().add(
                          const SendPhoneOtpEvent(),
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
