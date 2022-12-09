import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/ui/pages/home_page/random_cat_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'random_cat_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CatInteractor>()])
void main() {
  late RandomCatBloc bloc;
  late CatInteractor mockInteractor;

  setUp(() {
    mockInteractor = MockCatInteractor();

    bloc = RandomCatBloc(mockInteractor);
  });

  tearDown(() {
    bloc.close();
  });

  group('Happy Cases', () {
    test('when screen started', () {
      // Assert
      expect(
        bloc.state,
        equals(
          RandomCatInitial(),
        ),
      );
    });

    test('when a getrandomcatevent occurs, the loading start and after a cat is returned', () {
      // Arrange
      Cat expectedCat = Cat(picture: Uint8List(1));
      when(mockInteractor.getRandomCat()).thenAnswer((_) async => expectedCat);

      // Act
      bloc.add(GetRandomCatEvent());

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            RandomCatLoading(),
            RandomCatContentReady(cat: expectedCat),
          ],
        ),
      );
    });

    test('when a cat is liked, its added to the liked cats', () {
      // Arrange
      Cat likedCat = Cat(picture: Uint8List(1));

      // Act
      bloc.add(LikeRandomCatEvent(likedCat));

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [],
        ),
      );
    });

    test('when a cat is liked, its added to the liked cats', () {
      // Arrange
      Cat likedCat = Cat(picture: Uint8List(1));

      // Act
      bloc.add(LikeRandomCatEvent(likedCat));

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [],
        ),
      );
    });
  });

  group("Error Cases", () {
    test('when a getrandomcatevent occurs, the loading start and after an error is returned', () {
      // Arrange
      when(mockInteractor.getRandomCat()).thenThrow(Exception());

      // Act
      bloc.add((GetRandomCatEvent()));

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            RandomCatLoading(),
            // TODO: figure out how to verify error state that returns a stacktrace
          ],
        ),
      );
    });

    test('when a likeCatEvent occurs, the loading start and after an error is returned', () {
      // Arrange
      Cat expectedCat = Cat(picture: Uint8List(0));
      when(mockInteractor.likeCat(expectedCat)).thenThrow(Exception());

      // Act
      bloc.add((LikeRandomCatEvent(expectedCat)));

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            // TODO: figure out how to verify error state that returns a stacktrace
          ],
        ),
      );
    });

    test('when a dislikeCatEvent occurs, the loading start and after an error is returned', () {
      // Arrange
      Cat expectedCat = Cat(picture: Uint8List(0));
      when(mockInteractor.dislikeCat(expectedCat)).thenThrow(Exception());

      // Act
      bloc.add((DislikeRandomCatEvent(expectedCat)));

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            // TODO: figure out how to verify error state that returns a stacktrace
          ],
        ),
      );
    });
  });
}
