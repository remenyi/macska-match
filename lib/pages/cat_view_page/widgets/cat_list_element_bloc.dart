import 'package:bloc/bloc.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';
import 'package:meta/meta.dart';

part 'cat_list_element_event.dart';

part 'cat_list_element_state.dart';

class CatListElementBloc extends Bloc<CatListElementEvent, CatListElementState> {
  final CatInteractor _catInteractor;

  CatListElementBloc(this._catInteractor) : super(CatListElementInitial()) {
    on<GetCatListElementEvent>((event, emit) async {
      emit(CatListElementLoading());
      try {
        final cat = await _catInteractor.getCat(event.catUri);
        emit(CatListElementContentReady(cat));
      } catch (e) {
        emit(CatListElementGetError(e.toString()));
      }
    });

    on<DeleteCatListElementEvent>((event, emit) async {
      try {
        await _catInteractor.deleteCat(event.catUri);
        emit(CatListElementDeleted(event.index));
      } catch (e) {
        emit(CatListElementDeleteError(e.toString()));
      }
    });
  }
}
