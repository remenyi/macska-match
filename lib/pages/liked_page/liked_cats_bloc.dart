import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:meta/meta.dart';

part 'liked_cats_event.dart';
part 'liked_cats_state.dart';

class LikedCatsBloc extends Bloc<LikedCatsEvent, LikedCatsState> {
  final CatInteractor _catInteractor;

  LikedCatsBloc(this._catInteractor) : super(LikedCatsInitial()) {
    on<GetLikedCatsEvent>(
      (event, emit) async {
        emit(LikedCatsLoading());
        try {
          final cats = await _catInteractor.getLikedCats();
          emit(LikedCatsContentReady(cats));
        } catch (e) {
          emit(LikedCatsError());
        }
      },
    );
  }
}
