part of 'cats_view_bloc.dart';

@immutable
abstract class CatsViewEvent {}

class GetLikedCatsEvent extends CatsViewEvent {
  static final GetLikedCatsEvent _instance = GetLikedCatsEvent._();

  factory GetLikedCatsEvent() => _instance;

  GetLikedCatsEvent._();
}

class GetDislikedCatsEvent extends CatsViewEvent {
  static final GetDislikedCatsEvent _instance = GetDislikedCatsEvent._();

  factory GetDislikedCatsEvent() => _instance;

  GetDislikedCatsEvent._();
}

class CatListEmptiedEvent extends CatsViewEvent {
  static final CatListEmptiedEvent _instance = CatListEmptiedEvent._();

  factory CatListEmptiedEvent() => _instance;

  CatListEmptiedEvent._();
}
