part of 'random_cat_bloc.dart';

@immutable
abstract class RandomCatState {
  const RandomCatState();
}

class RandomCatInitial extends RandomCatState {
  static const RandomCatInitial _instance = RandomCatInitial._();

  factory RandomCatInitial() => _instance;

  const RandomCatInitial._();
}

class RandomCatLoading extends RandomCatState {
  static const RandomCatLoading _instance = RandomCatLoading._();

  factory RandomCatLoading() => _instance;

  const RandomCatLoading._();
}

class RandomCatContentReady extends RandomCatState with EquatableMixin {
  final Cat cat;

  const RandomCatContentReady({required this.cat});

  @override
  List<Object?> get props => [cat];
}

class RandomCatError extends RandomCatState with EquatableMixin {
  final String errorMessage;

  RandomCatError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class GetRandomCatError extends RandomCatError {
  GetRandomCatError(super.errorMessage);
}

class LikeRandomCatError extends RandomCatError {
  LikeRandomCatError(super.errorMessage);
}

class DislikeRandomCatError extends RandomCatError {
  DislikeRandomCatError(super.errorMessage);
}
