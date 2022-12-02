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

class CatListElementContentReady extends CatListElementState {
  final Cat cat;

  CatListElementContentReady(this.cat);
}

class CatListElementError extends CatListElementState {
  final String error;

  CatListElementError(this.error);
}
