part of 'liked_cats_bloc.dart';

@immutable
abstract class LikedCatsEvent {}

class GetLikedCatsEvent extends LikedCatsEvent {
  static final GetLikedCatsEvent _instance = GetLikedCatsEvent._();

  factory GetLikedCatsEvent() => _instance;

  GetLikedCatsEvent._();
}
