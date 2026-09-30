import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_state.dart';
import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/forget_password_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/register_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/Homescreen/homescreen.dart';
import 'package:purohitset_app/Widget/common_background.dart';

import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginBloc(AuthRepository()),

      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // ==========================
          // LOGIN SUCCESS
          // ==========================

          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successful")));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          }

          // ==========================
          // LOGIN FAILURE
          // ==========================

          if (state is LoginFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
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
                  final isWideLandscape = isLandscape && size.width >= 620;
                  final isTablet = size.width >= 600;

                  final logoSize = isLandscape
                      ? (size.height * 0.28).clamp(70.0, 130.0)
                      : (size.height * 0.17).clamp(90.0, 160.0);

                  Widget buildLogoHeader() {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'Assets/Images/purohit-setu-logo.webp',
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            String loginType = "Yajman";
                            if (state is LoginIntialState) {
                              loginType = state.loginType;
                            }
                            return AppTitle(title: "$loginType Login");
                          },
                        ),
                      ],
                    );
                  }

                  Widget buildFormFields() {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login As",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            String selectedType = "Yajman";
                            if (state is LoginIntialState) {
                              selectedType = state.loginType;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<LoginBloc>().add(
                                          const LoginTypeChanged("Yajman"),
                                        );

                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              duration:
                                                  const Duration(seconds: 4),
                                              content: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF1E1E1E),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFFFCD42),
                                                    width: 1.2,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color.fromARGB(
                                                        255,
                                                        250,
                                                        250,
                                                        250,
                                                      ).withValues(alpha: 0.25),
                                                      blurRadius: 12,
                                                    ),
                                                  ],
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.temple_hindu,
                                                      color: Color(0xFFFFCD42),
                                                      size: 28,
                                                    ),
                                                    SizedBox(width: 12),
                                                    Expanded(
                                                      child: Text(
                                                        "Yajman services are coming soon. We're preparing a better experience for you!",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                      },
                                      child: Container(
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          color: selectedType == "Yajman"
                                              ? const Color(0xFFFFCD42)
                                              : const Color(
                                                  0xFFFFCD42,
                                                ).withValues(alpha: 0.15),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                "Yajman",
                                                style: TextStyle(
                                                  color: selectedType == "Yajman"
                                                      ? Colors.black87
                                                      : Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<LoginBloc>().add(
                                          const LoginTypeChanged("Guruji"),
                                        );
                                      },
                                      child: Container(
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          color: selectedType == "Guruji"
                                              ? const Color(0xFFFFCD42)
                                              : const Color(
                                                  0xFFFFCD42,
                                                ).withValues(alpha: 0.15),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                "Guruji",
                                                style: TextStyle(
                                                  color: selectedType == "Guruji"
                                                      ? Colors.black87
                                                      : Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        FormTextField(
                          controller: userNameController,
                          label: "Enter the Phone Number",
                          keyboardType: TextInputType.phone,
                          prefixIcon: const Icon(Icons.phone, color: Colors.white),
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final isVisible = state is LoginIntialState
                                ? state.isPasswordVisible
                                : false;

                            return FormTextField(
                              controller: passwordController,
                              label: "Enter the Password",
                              obscureText: !isVisible,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    PasswordVisibilityChanged(!isVisible),
                                  );
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                            );
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
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  "Forget Password",
                                  style: TextStyle(
                                    color: Color(0xFFFFCD42),
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return const SizedBox(
                                height: 48,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFFCD42),
                                  ),
                                ),
                              );
                            }

                            String loginType = "Yajman";
                            if (state is LoginIntialState) {
                              loginType = state.loginType;
                            }

                            return FamoElevatedButton(
                              text: "Login as $loginType",
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homescreen(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 4,
                                ),
                                child: Text(
                                  " Register",
                                  style: TextStyle(
                                    color: Color(0xFFFFCD42),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }

                  if (isWideLandscape) {
                    // Landscape 2-column layout
                    return Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 880),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Center(child: buildLogoHeader()),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                flex: 6,
                                child: buildFormFields(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  // Portrait and compact layout
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 32 : 20,
                          vertical: isLandscape ? 12 : 20,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: isLandscape ? 8 : 16),
                            buildLogoHeader(),
                            SizedBox(height: isLandscape ? 16 : 24),
                            buildFormFields(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
