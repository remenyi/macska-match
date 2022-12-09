part of 'swipe_bloc.dart';

@immutable
abstract class SwipeEvent {}

class RightSwipeEvent extends SwipeEvent with EquatableMixin {
  final Cat cat;

  RightSwipeEvent(this.cat);

  @override
  List<Object?> get props => [cat];
}

class LeftSwipeEvent extends SwipeEvent with EquatableMixin {
  final Cat cat;

  LeftSwipeEvent(this.cat);

  @override
  List<Object?> get props => [cat];
}
