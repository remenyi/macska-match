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

class LikedCatsEmpty extends LikedCatsState {
  static final LikedCatsEmpty _instance = LikedCatsEmpty._();

  factory LikedCatsEmpty() => _instance;

  LikedCatsEmpty._();
}

class LikedCatContentReady extends LikedCatsState with EquatableMixin {
  final Cat cat;

  LikedCatContentReady(this.cat);

  @override
  List<Object?> get props => [cat];
}

class LikedCatsError extends LikedCatsState {
  final String errorMessage;

  LikedCatsError(this.errorMessage);
}
