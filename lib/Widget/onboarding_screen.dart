import 'package:animate_text/animate_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Bloc/Onboarding/onboarding_bloc.dart';
import 'package:purohitset_app/Bloc/Onboarding/onboarding_event.dart';
import 'package:purohitset_app/Bloc/Onboarding/onboarding_state.dart';
import 'package:purohitset_app/Model/Onboarding_Model/onboarding_model.dart';
import 'package:purohitset_app/Views/Auth/login_screen.dart';

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

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 242, 228),
            body: Container(
              decoration: BoxDecoration(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              context.read<OnboardingBloc>().add(
                                SkipOnboardingEvent(),
                              );
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      ),

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

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Image
                                  ImageRippleAnimation(
                                    image: page.image,
                                    imageSize: 220,
                                  ),

                                  const SizedBox(height: 20),

                                  AnimateText(
                                    page.title,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xFFFFD700), // Golden
                                      fontWeight: FontWeight.w600,
                                      shadows: [
                                        Shadow(
                                          color: Color(
                                            0xFFFFD700,
                                          ).withValues(alpha: 0.8),
                                          blurRadius: 12,
                                          offset: Offset(0, 0),
                                        ),
                                        Shadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.8,
                                          ),
                                          blurRadius: 4,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    type: AnimateTextType.bottomToTop,
                                  ),

                                  const SizedBox(height: 10),

                                  // Description
                                  Text(
                                    page.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      color: Color.fromARGB(255, 249, 242, 242),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      Row(
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
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 30),

            
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
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
                                    minimumSize: const Size(
                                      double.infinity,
                                      55,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Back',
                                    style: TextStyle(fontSize: 16),
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
                                  backgroundColor: Color(
                                    0xFFFFD700,
                                  ).withValues(alpha: 0.9),
                                  foregroundColor: const Color.fromARGB(
                                    255,
                                    106,
                                    103,
                                    103,
                                  ),
                                  minimumSize: const Size(double.infinity, 55),
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
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
