part of 'cat_list_element_bloc.dart';

@immutable
abstract class CatListElementState {}

class CatListElementInitial extends CatListElementState {
  static final CatListElementInitial _instance = CatListElementInitial._();

  factory CatListElementInitial() => _instance;

  CatListElementInitial._();
}

class CatListElementLoading extends CatListElementState {
  static final CatListElementLoading _instance = CatListElementLoading._();

  factory CatListElementLoading() => _instance;

  CatListElementLoading._();
}

class CatListElementContentReady extends CatListElementState with EquatableMixin {
  final Cat cat;

  CatListElementContentReady(this.cat);

  @override
  List<Object?> get props => [cat];
}

class CatListElementDeleted extends CatListElementState with EquatableMixin {
  final int index;

  CatListElementDeleted(this.index);

  @override
  List<Object?> get props => [index];
}

class CatListElementGetError extends CatListElementState with EquatableMixin {
  final String error;

  CatListElementGetError(this.error);

  @override
  List<Object?> get props => [error];
}

class CatListElementDeleteError extends CatListElementState with EquatableMixin {
  final String error;

  CatListElementDeleteError(this.error);

  @override
  List<Object?> get props => [error];
}
