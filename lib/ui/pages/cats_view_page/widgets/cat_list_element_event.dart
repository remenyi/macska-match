part of 'cat_list_element_bloc.dart';

@immutable
abstract class CatListElementEvent {}

class GetCatListElementEvent extends CatListElementEvent with EquatableMixin {
  final CatUriModel catUri;

  GetCatListElementEvent(this.catUri);

  @override
  List<Object?> get props => [catUri];
}

class DeleteCatListElementEvent extends CatListElementEvent with EquatableMixin {
  final CatUriModel catUri;
  final int index;

  DeleteCatListElementEvent(this.catUri, this.index);

  @override
  List<Object?> get props => [catUri, index];
}
