import 'package:animate_text/animate_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Bloc/SplashScreens/splash_screen_bloc.dart';
import 'package:purohitset_app/Bloc/SplashScreens/splash_screen_event.dart';
import 'package:purohitset_app/Bloc/SplashScreens/splash_screen_state.dart';
import 'package:purohitset_app/Constant/responsive.dart';
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
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Builder(
                  builder: (context) {
                    final size = MediaQuery.sizeOf(context);
                    final isLandscape =
                        MediaQuery.orientationOf(context) ==
                        Orientation.landscape;
                    final logoSize = isLandscape
                        ? (size.height * 0.35).clamp(120.0, 200.0)
                        : Responsive.isSmallPhone(context)
                        ? 150.0
                        : Responsive.isMobile(context)
                        ? 200.0
                        : Responsive.isTablet(context)
                        ? 220.0
                        : 240.0;
                    final fontSize = isLandscape
                        ? 18.0
                        : (size.width < 360
                              ? 18.0
                              : (size.width > 600 ? 26.0 : 22.0));

                    return Column(
                      children: [
                        SizedBox(height: isLandscape ? 80 : 220),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(
                                  255,
                                  99,
                                  84,
                                  0,
                                ).withValues(alpha: 0.8),
                                blurRadius: 180,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "Assets/Images/purohit-setu-logo.webp",
                            width: logoSize,
                            height: logoSize,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: AnimateText(
                            "Connect with Trusted Purohits!",
                            style: TextStyle(
                              fontSize: fontSize,
                              color: const Color(0xFFFFD700),
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  color: const Color(
                                    0xFFFFD700,
                                  ).withValues(alpha: 0.8),
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
    );
  }
}
