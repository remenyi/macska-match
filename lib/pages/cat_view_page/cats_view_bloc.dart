import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';
import 'package:meta/meta.dart';

part 'cats_view_event.dart';

part 'cats_view_state.dart';

class CatsViewBloc extends Bloc<CatsViewEvent, CatsViewState> {
  final CatInteractor _catInteractor;

  CatsViewBloc(this._catInteractor) : super(CatsViewInitial()) {
    on<CatsViewEvent>(
      (event, emit) async {
        emit(CatsViewLoading());
        try {
          final catUris = event.runtimeType == GetDislikedCatsEvent
              ? await _catInteractor.getDislikedCatUris()
              : await _catInteractor.getLikedCatUris();

          if (catUris.isEmpty) {
            emit(CatsViewEmpty());
          } else {
            emit(CatsViewContentReady(catUris));
          }
        } catch (e) {
          emit(CatsViewError(e.toString()));
        }
      },
    );
  }
}
