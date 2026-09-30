import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final int totalPages;

  OnboardingBloc({this.totalPages = 3})
    : super(OnboardingInitial(currentPage: 0, bubbleAnimation: true)) {
    on<NextOnboardingEvent>(_onNextPage);
    on<PreviousOnboardingEvent>(_onPreviousPage);
    on<PageChangedOnboardingEvent>(_onPageChanged);
    on<SkipOnboardingEvent>(_onSkip);
    on<GetStartedEvent>(_onGetStarted);

    on<StartBubbleAnimationEvent>(_onStartBubbleAnimation);
    on<StopBubbleAnimationEvent>(_onStopBubbleAnimation);
    on<RippleEvent>(_onRipple);
  }

  void _onNextPage(NextOnboardingEvent event, Emitter<OnboardingState> emit) {
    int currentPage = _getCurrentPage();

    if (currentPage < totalPages - 1) {
      currentPage++;

      emit(OnboardingPageChanged(currentPage, bubbleAnimation: true));
    } else {
      emit(OnboardingCompleted());
    }
  }

  void _onPreviousPage(
    PreviousOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) {
    int currentPage = _getCurrentPage();

    if (currentPage > 0) {
      currentPage--;

      emit(OnboardingPageChanged(currentPage, bubbleAnimation: true));
    }
  }

  void _onPageChanged(
    PageChangedOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) {
    emit(OnboardingPageChanged(event.page, bubbleAnimation: true));
  }

  // SKIP
  void _onSkip(SkipOnboardingEvent event, Emitter<OnboardingState> emit) {
    final box = GetStorage();

    box.write('onboarding_completed', true);

    emit(OnboardingCompleted());
  }

  // GET STARTED
  void _onGetStarted(GetStartedEvent event, Emitter<OnboardingState> emit) {
    final box = GetStorage();

    box.write('onboarding_completed', true);

    emit(OnboardingCompleted());
  }

  void _onStartBubbleAnimation(
    StartBubbleAnimationEvent event,
    Emitter<OnboardingState> emit,
  ) {
    int currentPage = _getCurrentPage();

    emit(BubbleAnimationStarted(currentPage));
  }

  void _onStopBubbleAnimation(
    StopBubbleAnimationEvent event,
    Emitter<OnboardingState> emit,
  ) {
    int currentPage = _getCurrentPage();

    emit(BubbleAnimationStopped(currentPage));
  }

  void _onRipple(RippleEvent event, Emitter<OnboardingState> emit) {
    int currentPage = _getCurrentPage();

    emit(RippleStarted(currentPage));
  }

  int _getCurrentPage() {
    if (state is OnboardingInitial) {
      return (state as OnboardingInitial).currentPage;
    }

    if (state is OnboardingPageChanged) {
      return (state as OnboardingPageChanged).currentPage;
    }

    if (state is BubbleAnimationStarted) {
      return (state as BubbleAnimationStarted).currentPage;
    }

    if (state is BubbleAnimationStopped) {
      return (state as BubbleAnimationStopped).currentPage;
    }

    if (state is RippleStarted) {
      return (state as RippleStarted).currentPage;
    }

    return 0;
  }
}
