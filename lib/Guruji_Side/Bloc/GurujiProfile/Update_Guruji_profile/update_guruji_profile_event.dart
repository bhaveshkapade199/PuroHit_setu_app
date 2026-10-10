import 'package:equatable/equatable.dart';

abstract class GurujiProfileUpdateEvent extends Equatable {
  const GurujiProfileUpdateEvent();

  @override
  List<Object?> get props => [];
}

class UpdateGurujiProfileEvent extends GurujiProfileUpdateEvent {
  final Map<String, dynamic> profileData;

  const UpdateGurujiProfileEvent({required this.profileData});

  @override
  List<Object?> get props => [profileData];
}
