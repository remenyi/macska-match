import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/domain/model/cat.dart';

part 'disliked_cats_event.dart';

part 'disliked_cats_state.dart';

class DislikedCatsBloc extends Bloc<DislikedCatsEvent, DislikedCatsState> {
  final CatInteractor _catInteractor;

  DislikedCatsBloc(this._catInteractor) : super(DislikedCatsInitial()) {
    on<GetDislikedCatsEvent>(
      (event, emit) async {
        emit(DislikedCatsLoading());
        try {
          if (await _catInteractor.isDislikedCatsEmpty()) {
            emit(DislikedCatsEmpty());
          }
          await emit.forEach(
            _catInteractor.getDislikedCats(),
            onData: (cat) => DislikedCatContentReady(cat as Cat),
          );
        } catch (e, s) {
          emit(DislikedCatsError(s.toString()));
        }
      },
    );
  }
}
