import 'package:bloc/bloc.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:meta/meta.dart';

part 'disliked_cats_event.dart';
part 'disliked_cats_state.dart';

class DislikedCatsBloc extends Bloc<DislikedCatsEvent, DislikedCatsState> {
  final CatInteractor _catInteractor;

  DislikedCatsBloc(this._catInteractor) : super(DislikedCatsInitial()) {
    on<DislikedCatsEvent>((event, emit) async {
      emit(DislikedCatsLoading());
      try {
        final cats = await _catInteractor.getDislikedCats();
        emit(DislikedCatsContentReady(cats));
      } catch (e) {
        emit(DislikedCatsError());
      }
    });
  }
}
