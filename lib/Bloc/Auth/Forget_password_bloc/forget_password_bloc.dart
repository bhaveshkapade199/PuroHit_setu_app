import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Bloc/Auth/Forget_password_bloc/forget_password_event.dart';
import 'package:purohitset_app/Bloc/Auth/Forget_password_bloc/forget_password_state.dart';
import 'package:purohitset_app/Repository/Auth/auth_repository.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPassInitialState()) {
    on<ForgetPasswordReqEvent>(_onForgetPasswordRequest);
  }

  Future<void> _onForgetPasswordRequest(
    ForgetPasswordReqEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoadingState());

    try {
      final response = await AuthRepository().forgetPassfunction(
        event.mobileNum,
        event.purpose,
      );

      if (response != null && response.success == true) {
        emit(ForgetPasswordSuccessState(response));
      } else {
        emit(
          ForgetPasswordErrorState(response?.message ?? 'Something went wrong'),
        );
      }
    } catch (e) {
      emit(
        ForgetPasswordErrorState(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }
}
