import 'package:equatable/equatable.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_profile_model.dart';

abstract class GurujiProfileState extends Equatable {
  const GurujiProfileState();

  @override
  List<Object?> get props => [];
}

// Initial State
class GurujiProfileInitialState extends GurujiProfileState {}



// Loading State
class GurujiProfileLoadingState extends GurujiProfileState {}

// Success State
class GurujiProfileSuccessState extends GurujiProfileState {
  final GurujiProfileInfoModel profile;

  const GurujiProfileSuccessState(this.profile);

  @override
  List<Object?> get props => [profile];
}

// Error State
class GurujiProfileErrorState extends GurujiProfileState {
  final String message;

  const GurujiProfileErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
