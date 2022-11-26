part of 'disliked_cats_bloc.dart';

@immutable
abstract class DislikedCatsState {}

class DislikedCatsInitial extends DislikedCatsState {
  static final DislikedCatsInitial _instance = DislikedCatsInitial._();

  factory DislikedCatsInitial() => _instance;

  DislikedCatsInitial._();
}

class DislikedCatsLoading extends DislikedCatsState {
  static final DislikedCatsLoading _instance = DislikedCatsLoading._();

  factory DislikedCatsLoading() => _instance;

  DislikedCatsLoading._();
}

class DislikedCatsContentReady extends DislikedCatsState {
  final List<Cat> cats;

  DislikedCatsContentReady(this.cats);
}

class DislikedCatsError extends DislikedCatsState {
  static final DislikedCatsError _instance = DislikedCatsError._();

  factory DislikedCatsError() => _instance;

  DislikedCatsError._();
}
