import 'package:animate_text/animate_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Bloc/SplashScreens/splash_screen_bloc.dart';
import 'package:purohitset_app/Bloc/SplashScreens/splash_screen_event.dart';
import 'package:purohitset_app/Bloc/SplashScreens/splash_screen_state.dart';
import 'package:purohitset_app/Views/Auth/login_screen.dart';
import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),

      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          // Onboarding already completed
          if (state is SplashCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }

          // First time user
          if (state is SplashShowOnboarding) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          }
        },

        child: Scaffold(
          body: CommonBackground(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              99,
                              84,
                              0,
                            ).withValues(alpha: 0.8),
                            blurRadius: 300,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "Assets/Images/purohit-setu-logo.webp",
                      ),
                    ),
                  ),

                  AnimateText(
                    "Connect with Trusted Purohits!",
                    style: TextStyle(
                      fontSize: 22,
                      color: const Color(0xFFFFD700),
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.8),
                          blurRadius: 12,
                          offset: const Offset(0, 0),
                        ),
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.8),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    type: AnimateTextType.bottomToTop,
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
