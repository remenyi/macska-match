part of 'disliked_cats_bloc.dart';

@immutable
abstract class DislikedCatsEvent {}

class GetDislikedCatsEvent extends DislikedCatsEvent {
  static final GetDislikedCatsEvent _instance = GetDislikedCatsEvent._();

  factory GetDislikedCatsEvent() => _instance;

  GetDislikedCatsEvent._();
}
