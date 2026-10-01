import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/SplashScreens/splash_screen_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/SplashScreens/splash_screen_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 8));

    final box = GetStorage();

    final bool isOnboardingCompleted =
        box.read('onboarding_completed') ?? false;

    if (isOnboardingCompleted) {
      emit(SplashCompleted());
    } else {
      emit(SplashShowOnboarding());
    }
  }
}
