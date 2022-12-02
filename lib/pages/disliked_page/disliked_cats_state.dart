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

class DislikedCatsEmpty extends DislikedCatsState {
  static final DislikedCatsEmpty _instance = DislikedCatsEmpty._();

  factory DislikedCatsEmpty() => _instance;

  DislikedCatsEmpty._();
}

class DislikedCatContentReady extends DislikedCatsState with EquatableMixin {
  final Cat cat;

  DislikedCatContentReady(this.cat);

  @override
  List<Object?> get props => [cat];
}

class DislikedCatDeleted extends DislikedCatsState with EquatableMixin {
  final int index;

  DislikedCatDeleted(this.index);

  @override
  List<Object?> get props => [index];
}

class DislikedCatsError extends DislikedCatsState {
  final String errorMessage;

  DislikedCatsError(this.errorMessage);
}
