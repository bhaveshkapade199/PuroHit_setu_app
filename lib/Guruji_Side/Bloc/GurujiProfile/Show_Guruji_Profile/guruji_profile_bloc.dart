import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_state.dart';
import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';

class GurujiProfileBloc extends Bloc<GurujiProfileEvent, GurujiProfileState> {
  final AuthRepository repository;

  GurujiProfileBloc(this.repository) : super(GurujiProfileInitialState()) {
    on<GetGurujiDetailEvent>((event, emit) async {
      emit(GurujiProfileLoadingState());

      try {
        debugPrint("PROFILE: API request started");

        final profile = await repository.getGurujiDetail();

        debugPrint("PROFILE: Model parsing completed");
        debugPrint("PROFILE: Profile model received");

        emit(GurujiProfileSuccessState(profile));

        debugPrint("PROFILE: Success state emitted");
      } catch (e, stackTrace) {
        debugPrint("PROFILE BLOC ERROR: $e");
        debugPrint("PROFILE STACKTRACE: $stackTrace");

        emit(GurujiProfileErrorState(e.toString()));
      }
    });
  }
}
