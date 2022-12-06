part of 'random_cat_bloc.dart';

@immutable
abstract class RandomCatEvent {}

class GetRandomCatEvent extends RandomCatEvent {
  static final GetRandomCatEvent _instance = GetRandomCatEvent._();

  factory GetRandomCatEvent() => _instance;

  GetRandomCatEvent._();
}

class LikeRandomCatEvent extends RandomCatEvent with EquatableMixin {
  final Cat cat;

  LikeRandomCatEvent(this.cat);

  @override
  List<Object?> get props => [cat];
}

class DislikeRandomCatEvent extends RandomCatEvent with EquatableMixin {
  final Cat cat;

  DislikeRandomCatEvent(this.cat);

  @override
  List<Object?> get props => [cat];
}
