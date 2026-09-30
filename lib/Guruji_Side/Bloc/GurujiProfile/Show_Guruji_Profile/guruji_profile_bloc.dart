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
        final profile = await repository.getGurujiDetail();

        emit(GurujiProfileSuccessState(profile));
      } catch (e) {
        emit(GurujiProfileErrorState(e.toString()));
      }
    });
  }
}
