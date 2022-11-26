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

class GetRandomCatError extends RandomCatState {
  static const GetRandomCatError _instance = GetRandomCatError._();

  factory GetRandomCatError() => _instance;

  const GetRandomCatError._();
}

class LikeRandomCatError extends RandomCatState {
  static const LikeRandomCatError _instance = LikeRandomCatError._();

  factory LikeRandomCatError() => _instance;

  const LikeRandomCatError._();
}

class DislikeRandomCatError extends RandomCatState {
  static const DislikeRandomCatError _instance = DislikeRandomCatError._();

  factory DislikeRandomCatError() => _instance;

  const DislikeRandomCatError._();
}
