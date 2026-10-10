import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Update_Guruji_profile/update_guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Update_Guruji_profile/update_guruji_profile_state.dart';
import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';

class GurujiProfileUpdateBloc
    extends Bloc<GurujiProfileUpdateEvent, GurujiProfileUpdateState> {
  final AuthRepository repository;

  GurujiProfileUpdateBloc({required this.repository})
    : super(GurujiProfileUpdateInitial()) {
    on<UpdateGurujiProfileEvent>(_onUpdateGurujiProfile);
  }

  Future<void> _onUpdateGurujiProfile(
    UpdateGurujiProfileEvent event,
    Emitter<GurujiProfileUpdateState> emit,
  ) async {
    emit(GurujiProfileUpdateLoading());

    try {
      final result = await repository.gurujiupdatefunction(event.profileData);

      if (result != null && result.success) {
        emit(GurujiProfileUpdateSuccess(result));
      } else {
        emit(
          GurujiProfileUpdateError(result?.message ?? 'Profile update failed.'),
        );
      }
    } catch (e) {
      emit(
        GurujiProfileUpdateError(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }
}
