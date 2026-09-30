abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {
  final int currentPage;
  final bool bubbleAnimation;

  OnboardingInitial({this.currentPage = 0, this.bubbleAnimation = true});
}

class OnboardingPageChanged extends OnboardingState {
  final int currentPage;
  final bool bubbleAnimation;

  OnboardingPageChanged(this.currentPage, {this.bubbleAnimation = true});
}

class OnboardingCompleted extends OnboardingState {}

class BubbleAnimationStarted extends OnboardingState {
  final int currentPage;

  BubbleAnimationStarted(this.currentPage);
}

class BubbleAnimationStopped extends OnboardingState {
  final int currentPage;

  BubbleAnimationStopped(this.currentPage);
}

class RippleStarted extends OnboardingState {
  final int currentPage;

  RippleStarted(this.currentPage);
}
