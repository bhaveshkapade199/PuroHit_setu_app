import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_state.dart';
import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/forget_password_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/register_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/Homescreen/homescreen.dart';
import 'package:purohitset_app/Widget/form_button.dart';
import 'package:purohitset_app/Widget/form_field.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';

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
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successful")));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          }

          if (state is LoginFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,

          // Important for keyboard handling
          resizeToAvoidBottomInset: true,

          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
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
                            horizontal: 30,
                            vertical: 8,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight - 288,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // =================================================
                                    // LOGIN AS
                                    // =================================================
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Login As",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // =================================================
                                    // YAJMAN / GURUJI
                                    // =================================================
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        String selectedType = "Yajman";

                                        if (state is LoginIntialState) {
                                          selectedType = state.loginType;
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // =================================================
                                              // YAJMAN
                                              // =================================================
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<LoginBloc>()
                                                        .add(
                                                          const LoginTypeChanged(
                                                            "Yajman",
                                                          ),
                                                        );

                                                    ScaffoldMessenger.of(
                                                        context,
                                                      )
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(
                                                        SnackBar(
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 0,
                                                          duration:
                                                              const Duration(
                                                                seconds: 4,
                                                              ),
                                                          content: Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  16,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xFF1E1E1E,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    16,
                                                                  ),
                                                              border: Border.all(
                                                                color:
                                                                    const Color(
                                                                      0xFFFFCD42,
                                                                    ),
                                                                width: 1.2,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color:
                                                                      const Color.fromARGB(
                                                                        255,
                                                                        250,
                                                                        250,
                                                                        250,
                                                                      ).withValues(
                                                                        alpha:
                                                                            0.25,
                                                                      ),
                                                                  blurRadius:
                                                                      12,
                                                                ),
                                                              ],
                                                            ),
                                                            child: const Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .temple_hindu,
                                                                  color: Color(
                                                                    0xFFFFCD42,
                                                                  ),
                                                                  size: 28,
                                                                ),
                                                                SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "Yajman services are coming soon. We're preparing a better experience for you!",
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
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
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            22,
                                                          ),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.amber,
                                                      ),
                                                      color:
                                                          selectedType ==
                                                              "Yajman"
                                                          ? const Color(
                                                              0xff66110b,
                                                            )
                                                          : const Color.fromARGB(
                                                              255,
                                                              255,
                                                              168,
                                                              46,
                                                            ),
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
                                                              color:
                                                                  selectedType ==
                                                                      "Yajman"
                                                                  ? Colors.white
                                                                  : Colors
                                                                        .black87,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                    context
                                                        .read<LoginBloc>()
                                                        .add(
                                                          const LoginTypeChanged(
                                                            "Guruji",
                                                          ),
                                                        );
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            22,
                                                          ),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.amber,
                                                      ),
                                                      color:
                                                          selectedType ==
                                                              "Guruji"
                                                          ? const Color(
                                                              0xff66110b,
                                                            )
                                                          : const Color.fromARGB(
                                                              255,
                                                              255,
                                                              168,
                                                              46,
                                                            ),
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
                                                              color:
                                                                  selectedType ==
                                                                      "Guruji"
                                                                  ? Colors.white
                                                                  : Colors
                                                                        .black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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

                                    // =================================================
                                    // PHONE NUMBER
                                    // =================================================
                                    FormTextField(
                                      controller: userNameController,
                                      label: "Enter the Phone Number",
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        color: Color(0xFF00674f),
                                      ),
                                    ),

                                    // =================================================
                                    // PASSWORD
                                    // =================================================
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        final isVisible =
                                            state.isPasswordVisible;

                                        return FormTextField(
                                          controller: passwordController,
                                          label: "Enter the Password",
                                          obscureText: !isVisible,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              context.read<LoginBloc>().add(
                                                PasswordVisibilityChanged(
                                                  !isVisible,
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              isVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Color(0xFF00674f),
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    // =================================================
                                    // FORGET PASSWORD
                                    // =================================================
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

                                    const SizedBox(height: 20),

                                    // =================================================
                                    // LOGIN BUTTON
                                    // =================================================
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        if (state is LoginLoadingState) {
                                          return Container(
                                            width: double.infinity,
                                            height: 48,
                                            padding: const EdgeInsets.all(0.7),

                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),

                                              // Outer border
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                  255,
                                                  251,
                                                  251,
                                                  251,
                                                ).withValues(alpha: 0.85),
                                                width: 1,
                                              ),

                                              color: const Color(
                                                0xff66110b,
                                              ).withValues(alpha: 0.55),
                                            ),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.amber,
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
                                            final phone = userNameController
                                                .text
                                                .trim();

                                            final password = passwordController
                                                .text
                                                .trim();

                                            if (phone.isEmpty ||
                                                password.isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Please enter phone number and password",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            context.read<LoginBloc>().add(
                                              LoginButtonPressed(
                                                username: phone,
                                                password: password,
                                                loginType: loginType,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 24),

                                    // =================================================
                                    // REGISTER
                                    // =================================================
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Don't have an account?",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterScreen(),
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 4,
                                            ),
                                            child: Text(
                                              " New Register",
                                              style: TextStyle(
                                                color: Color(0xFF00674f),
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 16),
                                  ],
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
        ),
      ),
    );
  }
}
