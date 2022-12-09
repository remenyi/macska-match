import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/interactors/cat_interactor.dart';
import '../../../domain/model/cat_uri_model.dart';

part 'cats_view_event.dart';

part 'cats_view_state.dart';

class CatsViewBloc extends Bloc<CatsViewEvent, CatsViewState> {
  final CatInteractor _catInteractor;

  CatsViewBloc(this._catInteractor) : super(CatsViewInitial()) {
    on<CatsViewEvent>(
      (event, emit) async {
        if (event is CatListEmptiedEvent) {
          emit(CatsViewEmpty());
          return;
        }
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
