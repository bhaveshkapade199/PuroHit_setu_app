abstract class OnboardingEvent {}

class NextOnboardingEvent extends OnboardingEvent {}

class PreviousOnboardingEvent extends OnboardingEvent {}

class SkipOnboardingEvent extends OnboardingEvent {}

class PageChangedOnboardingEvent extends OnboardingEvent {
  final int page;

  PageChangedOnboardingEvent(this.page);
}

class GetStartedEvent extends OnboardingEvent {}

// Bubble events
class StartBubbleAnimationEvent extends OnboardingEvent {}

class StopBubbleAnimationEvent extends OnboardingEvent {}

class RippleEvent extends OnboardingEvent {}
