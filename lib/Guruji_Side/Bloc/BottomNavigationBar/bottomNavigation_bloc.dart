import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_state.dart';



class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc()
      : super(const BottomNavigationState()) {
    on<BottomNavigationTabChanged>((event, emit) {
      emit(
        state.copyWith(
          currentIndex: event.index,
        ),
      );
    });
  }
}