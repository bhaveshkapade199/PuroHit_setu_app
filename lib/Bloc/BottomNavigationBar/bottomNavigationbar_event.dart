import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class BottomNavigationTabChanged extends BottomNavigationEvent {
  final int index;

  const BottomNavigationTabChanged(this.index);

  @override
  List<Object> get props => [index];
}
