import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/interactors/cat_interactor.dart';
import '../../../domain/model/cat.dart';

part 'random_cat_event.dart';

part 'random_cat_state.dart';

class RandomCatBloc extends Bloc<RandomCatEvent, RandomCatState> {
  final CatInteractor _catInteractor;

  RandomCatBloc(this._catInteractor) : super(RandomCatInitial()) {
    on<GetRandomCatEvent>(
      (event, emit) async {
        emit(RandomCatLoading());
        try {
          final cat = await _catInteractor.getRandomCat();
          emit(RandomCatContentReady(cat: cat));
        } catch (e, s) {
          emit(GetRandomCatError(s.toString()));
        }
      },
    );

    on<LikeRandomCatEvent>(
      (event, emit) async {
        try {
          await _catInteractor.likeCat(event.cat);
        } catch (e, s) {
          emit(LikeRandomCatError(s.toString()));
        }
      },
    );

    on<DislikeRandomCatEvent>(
      (event, emit) async {
        try {
          await _catInteractor.dislikeCat(event.cat);
        } catch (e, s) {
          emit(DislikeRandomCatError(s.toString()));
        }
      },
    );
  }
}
