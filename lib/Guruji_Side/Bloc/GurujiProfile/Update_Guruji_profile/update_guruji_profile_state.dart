import 'package:equatable/equatable.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_profile_update_model.dart';

abstract class GurujiProfileUpdateState extends Equatable {
  const GurujiProfileUpdateState();

  @override
  List<Object?> get props => [];
}

// Initial State
class GurujiProfileUpdateInitial extends GurujiProfileUpdateState {}

// Loading State
class GurujiProfileUpdateLoading extends GurujiProfileUpdateState {}

// Success State
class GurujiProfileUpdateSuccess extends GurujiProfileUpdateState {
  final GurujiProfileUpdateModel model;

  const GurujiProfileUpdateSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

// Error State
class GurujiProfileUpdateError extends GurujiProfileUpdateState {
  final String message;

  const GurujiProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}
