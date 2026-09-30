import 'package:animate_text/animate_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Onboarding/onboarding_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Onboarding/onboarding_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Onboarding/onboarding_state.dart';
import 'package:purohitset_app/Guruji_Side/Model/Onboarding_Model/onboarding_model.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/login_screen.dart';

import 'package:purohitset_app/Widget/image_ripple_animation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'Welcome to Our App',
      description:
          'Discover a simple and powerful way to manage everything in one place.',
      image: 'Assets/Images/purohit-setu-logo.webp',
    ),
    OnboardingModel(
      title: 'Explore Features',
      description:
          'Enjoy useful features designed to make your daily tasks easier and faster.',
      image: 'Assets/Images/purohit-setu-logo.webp',
    ),
    OnboardingModel(
      title: 'Get Started',
      description:
          'You are all set. Start using the application and enjoy the experience.',
      image: 'Assets/Images/purohit-setu-logo.webp',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingPageChanged) {
            _goToPage(state.currentPage);
          }

          if (state is OnboardingCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
        builder: (context, state) {
          int currentPage = 0;

          if (state is OnboardingInitial) {
            currentPage = state.currentPage;
          }

          if (state is OnboardingPageChanged) {
            currentPage = state.currentPage;
          }

          final size = MediaQuery.sizeOf(context);
          final isLandscape =
              MediaQuery.orientationOf(context) == Orientation.landscape;
          final isTablet = size.width >= 600;

          // Adaptive ripple image size
          final double rippleImageSize = isLandscape
              ? (size.height * 0.28).clamp(70.0, 130.0)
              : (size.height * 0.20).clamp(110.0, 210.0);

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 242, 228),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/Images/puja-path.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                ),
                child: SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isLandscape ? 850 : (isTablet ? 550 : double.infinity),
                      ),
                      child: Column(
                        children: [
                          // Skip button
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isTablet ? 24 : 12,
                                vertical: isLandscape ? 4 : 8,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  context.read<OnboardingBloc>().add(
                                    SkipOnboardingEvent(),
                                  );
                                },
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Content PageView
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: onboardingPages.length,
                              onPageChanged: (index) {
                                context.read<OnboardingBloc>().add(
                                  PageChangedOnboardingEvent(index),
                                );
                              },
                              itemBuilder: (context, index) {
                                final page = onboardingPages[index];

                                if (isLandscape) {
                                  // Landscape layout: side-by-side row
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Center(
                                            child: ImageRippleAnimation(
                                              image: page.image,
                                              imageSize: rippleImageSize,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          flex: 6,
                                          child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                AnimateText(
                                                  page.title,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFFFFD700),
                                                    fontWeight: FontWeight.w600,
                                                    shadows: [
                                                      Shadow(
                                                        color: Color(0xFFFFD700),
                                                        blurRadius: 10,
                                                      ),
                                                      Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 4,
                                                        offset: Offset(2, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  type: AnimateTextType.bottomToTop,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  page.description,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.4,
                                                    color: Color.fromARGB(
                                                      255,
                                                      249,
                                                      242,
                                                      242,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                // Portrait layout
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageRippleAnimation(
                                        image: page.image,
                                        imageSize: rippleImageSize,
                                      ),
                                      SizedBox(height: isTablet ? 30 : 20),
                                      AnimateText(
                                        page.title,
                                        style: TextStyle(
                                          fontSize: isTablet ? 26 : 22,
                                          color: const Color(0xFFFFD700),
                                          fontWeight: FontWeight.w600,
                                          shadows: const [
                                            Shadow(
                                              color: Color(0xFFFFD700),
                                              blurRadius: 12,
                                            ),
                                            Shadow(
                                              color: Colors.black,
                                              blurRadius: 4,
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                        type: AnimateTextType.bottomToTop,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        page.description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: isTablet ? 18 : 15,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5,
                                          color: const Color.fromARGB(
                                            255,
                                            249,
                                            242,
                                            242,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // Page dots
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: isLandscape ? 6 : 14,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(onboardingPages.length, (
                                index,
                              ) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  height: 8,
                                  width: currentPage == index ? 25 : 8,
                                  decoration: BoxDecoration(
                                    color: currentPage == index
                                        ? const Color(0xffedca80)
                                        : Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              }),
                            ),
                          ),

                          // Bottom buttons
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              isTablet ? 32 : 20,
                              4,
                              isTablet ? 32 : 20,
                              isLandscape ? 10 : 20,
                            ),
                            child: Row(
                              children: [
                                if (currentPage > 0)
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        context.read<OnboardingBloc>().add(
                                          PreviousOnboardingEvent(),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: Size(
                                          double.infinity,
                                          isLandscape ? 44 : 50,
                                        ),
                                        side: const BorderSide(
                                          color: Color(0xFFFFD700),
                                          width: 1.2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                if (currentPage > 0) const SizedBox(width: 15),

                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (currentPage ==
                                          onboardingPages.length - 1) {
                                        context.read<OnboardingBloc>().add(
                                          GetStartedEvent(),
                                        );
                                      } else {
                                        context.read<OnboardingBloc>().add(
                                          NextOnboardingEvent(),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFD700),
                                      foregroundColor: Colors.black87,
                                      minimumSize: Size(
                                        double.infinity,
                                        isLandscape ? 44 : 50,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      currentPage == onboardingPages.length - 1
                                          ? 'Get Started'
                                          : 'Next',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
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
          );
        },
      ),
    );
  }
}
