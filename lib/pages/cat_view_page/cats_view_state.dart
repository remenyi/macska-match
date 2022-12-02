part of 'cats_view_bloc.dart';

@immutable
abstract class CatsViewState {}

class CatsViewInitial extends CatsViewState {
  static final CatsViewInitial _instance = CatsViewInitial._();

  factory CatsViewInitial() => _instance;

  CatsViewInitial._();
}

class CatsViewLoading extends CatsViewState {
  static final CatsViewLoading _instance = CatsViewLoading._();

  factory CatsViewLoading() => _instance;

  CatsViewLoading._();
}

class CatsViewEmpty extends CatsViewState {
  static final CatsViewEmpty _instance = CatsViewEmpty._();

  factory CatsViewEmpty() => _instance;

  CatsViewEmpty._();
}

class CatsViewContentReady extends CatsViewState with EquatableMixin {
  final Iterable<CatUriModel> catUris;

  CatsViewContentReady(this.catUris);

  @override
  List<Object?> get props => [catUris];
}

class CatsViewError extends CatsViewState {
  final String errorMessage;

  CatsViewError(this.errorMessage);
}
