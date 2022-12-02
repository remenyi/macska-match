part of 'cat_list_element_bloc.dart';

@immutable
abstract class CatListElementEvent {}

class GetCatListElementEvent extends CatListElementEvent {
  final CatUriModel catUri;

  GetCatListElementEvent(this.catUri);
}
