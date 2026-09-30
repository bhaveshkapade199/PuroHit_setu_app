import 'package:equatable/equatable.dart';

abstract class GurujiProfileEvent extends Equatable {
  const GurujiProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetGurujiDetailEvent extends GurujiProfileEvent {
  const GetGurujiDetailEvent();
}
