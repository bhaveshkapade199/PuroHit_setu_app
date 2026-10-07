import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Constant/app_translations.dart';

abstract class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final String languageCode;
  ChangeLanguageEvent(this.languageCode);
}

abstract class LanguageState {
  final String languageCode;
  const LanguageState(this.languageCode);
}

class LanguageInitialState extends LanguageState {
  const LanguageInitialState(super.languageCode);
}

class LanguageChangedState extends LanguageState {
  const LanguageChangedState(super.languageCode);
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitialState(AppTranslations.currentLanguage)) {
    on<ChangeLanguageEvent>((event, emit) {
      AppTranslations.setLanguage(event.languageCode);
      emit(LanguageChangedState(event.languageCode));
    });
  }
}
