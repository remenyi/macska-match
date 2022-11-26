part of 'liked_cats_bloc.dart';

@immutable
abstract class LikedCatsState {}

class LikedCatsInitial extends LikedCatsState {
  static final LikedCatsInitial _instance = LikedCatsInitial._();

  factory LikedCatsInitial() => _instance;

  LikedCatsInitial._();
}

class LikedCatsLoading extends LikedCatsState {
  static final LikedCatsLoading _instance = LikedCatsLoading._();

  factory LikedCatsLoading() => _instance;

  LikedCatsLoading._();
}

class LikedCatsContentReady extends LikedCatsState with EquatableMixin {
  final List<Cat> cats;

  LikedCatsContentReady(this.cats);

  @override
  List<Object?> get props => [cats];
}

class LikedCatsError extends LikedCatsState {
  static final LikedCatsError _instance = LikedCatsError._();

  factory LikedCatsError() => _instance;

  LikedCatsError._();
}
