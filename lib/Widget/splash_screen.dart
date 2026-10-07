import 'package:animate_text/animate_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/SplashScreens/splash_screen_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/SplashScreens/splash_screen_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/SplashScreens/splash_screen_state.dart';
import 'package:purohitset_app/Constant/app_translations.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/login_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/Homescreen/homescreen.dart';
import 'package:purohitset_app/Widget/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          } else if (state is SplashCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else if (state is SplashShowOnboarding) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8EAC1),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background GIF
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 70),
                child: Image.asset(
                  "Assets/Gif/splash_screen.gif",
                  fit: BoxFit.cover,
                ),
              ),

              // Animated text at the bottom
              Positioned(
                left: 20,
                right: 20,
                bottom: 60,
                child: SafeArea(
                  top: false,
                  child: Center(
                    child: AnimateText(
                      AppTranslations.tr('splash_tagline'),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color(0xFF00674f),
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            color: Color(0xCCFFD700),
                            blurRadius: 12,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      type: AnimateTextType.bottomToTop,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
