part of 'swipe_bloc.dart';

@immutable
abstract class SwipeState {}

class SwipeInitial extends SwipeState {}

class SwipeError extends SwipeState with EquatableMixin {
  final String errorMessage;

  SwipeError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class RightSwipeError extends SwipeError {
  RightSwipeError(super.errorMessage);
}

class LeftSwipeError extends SwipeError {
  LeftSwipeError(super.errorMessage);
}
