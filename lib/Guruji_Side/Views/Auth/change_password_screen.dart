import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Chanfe_Password_Profile/change_password.bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Chanfe_Password_Profile/change_password_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Chanfe_Password_Profile/change_password_state.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/forget_password_screen.dart';

import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<String> _currentPassword = ValueNotifier<String>('');

  final ValueNotifier<String> _newPassword = ValueNotifier<String>('');

  final ValueNotifier<String> _confirmPassword = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Logo section
              Column(
                children: [
                  SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: Center(
                      child: Image.asset(
                        'Assets/Images/purohit-setu-logo.webp',
                      ),
                    ),
                  ),
                ],
              ),

              // Gold background design
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: RPSCustomPainter(
                      fillColor: const Color(0xffcd9933).withValues(alpha: 0.5),
                      strokeColor: const Color(0xffffd873),
                    ),
                  ),
                ),
              ),

              // Form section
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 240),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 288,
                        ),
                        child: Form(
                          key: _formKey,
                          child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                            builder: (context, visibilityState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Screen title
                                  const Center(
                                    child: Text(
                                      'Change Password',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  // Current Password
                                  FormTextField(
                                    label: 'Enter Current Password',
                                    obscureText: !visibilityState
                                        .isCurrentPasswordVisible,
                                    suffixIcon: IconButton(
                                      tooltip:
                                          visibilityState
                                              .isCurrentPasswordVisible
                                          ? 'Hide password'
                                          : 'Show password',
                                      onPressed: () {
                                        context.read<ChangePasswordBloc>().add(
                                          ToggleCurrentPasswordVisibility(),
                                        );
                                      },
                                      icon: Icon(
                                        visibilityState.isCurrentPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    onSaved: (value) {
                                      _currentPassword.value =
                                          value?.trim() ?? '';
                                    },
                                  ),

                                  const SizedBox(height: 10),

                                  // New Password
                                  FormTextField(
                                    label: 'Enter New Password',
                                    obscureText:
                                        !visibilityState.isNewPasswordVisible,
                                    suffixIcon: IconButton(
                                      tooltip:
                                          visibilityState.isNewPasswordVisible
                                          ? 'Hide password'
                                          : 'Show password',
                                      onPressed: () {
                                        context.read<ChangePasswordBloc>().add(
                                          ToggleNewPasswordVisibility(),
                                        );
                                      },
                                      icon: Icon(
                                        visibilityState.isNewPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    onSaved: (value) {
                                      _newPassword.value = value ?? '';
                                    },
                                  ),

                                  const SizedBox(height: 10),

                                  // Confirm Password
                                  FormTextField(
                                    label: 'Enter Confirm Password',
                                    obscureText: !visibilityState
                                        .isConfirmPasswordVisible,
                                    suffixIcon: IconButton(
                                      tooltip:
                                          visibilityState
                                              .isConfirmPasswordVisible
                                          ? 'Hide password'
                                          : 'Show password',
                                      onPressed: () {
                                        context.read<ChangePasswordBloc>().add(
                                          ToggleConfirmPasswordVisibility(),
                                        );
                                      },
                                      icon: Icon(
                                        visibilityState.isConfirmPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    onSaved: (value) {
                                      _confirmPassword.value = value ?? '';
                                    },
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPasswordScreen(),
                                            ),
                                          );
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            "Forget Password",
                                            style: TextStyle(
                                              color: Color(0xFF00674f),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 24),

                                  // Change Password button
                                  BlocConsumer<
                                    ChangePasswordBloc,
                                    ChangePasswordState
                                  >(
                                    listener: (context, state) {
                                      if (state is ChangePasswordSuccessState) {
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              content: Text(state.message),
                                            ),
                                          );

                                        _formKey.currentState?.reset();

                                        _currentPassword.value = '';
                                        _newPassword.value = '';
                                        _confirmPassword.value = '';
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (dialogContext) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              content: const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 60,
                                                  ),
                                                  SizedBox(height: 16),
                                                  Text(
                                                    'Your password has been changed successfully.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(
                                                      dialogContext,
                                                    ).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }

                                      if (state is ChangePasswordErrorState) {
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              content: Text(state.errorMessage),
                                            ),
                                          );
                                      }
                                    },
                                    builder: (context, state) {
                                      final isLoading =
                                          state is ChangePasswordLoadingState;

                                      return FamoElevatedButton(
                                        text: isLoading
                                            ? 'Please wait...'
                                            : 'Change Password',
                                        onPressed: isLoading
                                            ? null
                                            : () {
                                                final isValid =
                                                    _formKey.currentState
                                                        ?.validate() ??
                                                    false;

                                                if (!isValid) {
                                                  return;
                                                }

                                                _formKey.currentState?.save();

                                                final currentPassword =
                                                    _currentPassword.value;
                                                final newPassword =
                                                    _newPassword.value;
                                                final confirmPassword =
                                                    _confirmPassword.value;

                                                // Confirm password validation
                                                if (newPassword !=
                                                    confirmPassword) {
                                                  ScaffoldMessenger.of(context)
                                                    ..hideCurrentSnackBar()
                                                    ..showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'New password and confirm password do not match',
                                                        ),
                                                      ),
                                                    );
                                                  return;
                                                }

                                                // Dispatch API event
                                                context
                                                    .read<ChangePasswordBloc>()
                                                    .add(
                                                      ChangePasswordUserEvent(
                                                        currentpassword:
                                                            currentPassword,
                                                        newpassword:
                                                            newPassword,
                                                        confirmpassword:
                                                            confirmPassword,
                                                      ),
                                                    );
                                              },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
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
    );
  }
}
