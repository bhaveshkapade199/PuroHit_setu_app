import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepository repository;

  ChangePasswordBloc({required this.repository})
    : super(const ChangePasswordInitialState()) {
    on<ChangePasswordUserEvent>(_onChangePassword);

    on<ToggleCurrentPasswordVisibility>((event, emit) {
      emit(
        ChangePasswordInitialState(
          isCurrentPasswordVisible: !state.isCurrentPasswordVisible,
          isNewPasswordVisible: state.isNewPasswordVisible,
          isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        ),
      );
    });

    on<ToggleNewPasswordVisibility>((event, emit) {
      emit(
        ChangePasswordInitialState(
          isCurrentPasswordVisible: state.isCurrentPasswordVisible,
          isNewPasswordVisible: !state.isNewPasswordVisible,
          isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        ),
      );
    });

    on<ToggleConfirmPasswordVisibility>((event, emit) {
      emit(
        ChangePasswordInitialState(
          isCurrentPasswordVisible: state.isCurrentPasswordVisible,
          isNewPasswordVisible: state.isNewPasswordVisible,
          isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
        ),
      );
    });
  }

  Future<void> _onChangePassword(
    ChangePasswordUserEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(
      ChangePasswordLoadingState(
        isCurrentPasswordVisible: state.isCurrentPasswordVisible,
        isNewPasswordVisible: state.isNewPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      ),
    );

    try {
      final result = await repository.changePasswordFunction(
        event.currentpassword,
        event.newpassword,
        event.confirmpassword,
      );

      if (result.success) {
        emit(
          ChangePasswordSuccessState(
            message: result.message.isNotEmpty
                ? result.message
                : 'Password changed successfully.',
          ),
        );
      } else {
        emit(
          ChangePasswordErrorState(
            errorMessage: result.message.isNotEmpty
                ? result.message
                : 'Unable to change password.',
          ),
        );
      }
    } catch (e) {
      emit(
        ChangePasswordErrorState(
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
