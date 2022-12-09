import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:meta/meta.dart';

import '../../../../domain/model/cat.dart';

part 'swipe_event.dart';

part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final CatInteractor _catInteractor;

  SwipeBloc(this._catInteractor) : super(SwipeInitial()) {
    on<RightSwipeEvent>(
      (event, emit) async {
        try {
          await _catInteractor.likeCat(event.cat);
        } catch (e, s) {
          emit(RightSwipeError(s.toString()));
        }
      },
    );

    on<LeftSwipeEvent>(
      (event, emit) async {
        try {
          await _catInteractor.dislikeCat(event.cat);
        } catch (e, s) {
          emit(LeftSwipeError(s.toString()));
        }
      },
    );
  }
}
