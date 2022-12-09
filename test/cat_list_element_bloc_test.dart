import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';
import 'package:macska_match/ui/pages/cats_view_page/cats_view_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'random_cat_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CatInteractor>()])

void main() {
  late CatsViewBloc bloc;
  late CatInteractor mockInteractor;

  setUp(() {
    mockInteractor = MockCatInteractor();

    bloc = CatsViewBloc(mockInteractor);
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
          CatsViewInitial(),
        ),
      );
    });

    test('when a getLikedCatsEvent occurs, the loading start and after a list of liked cat uris are returned', () {
      // Arrange
      List<CatUriModel> expectedCatUris = [CatUriModel(uri: "dönci", timestamp: Timestamp.now())];
      when(mockInteractor.getLikedCatUris()).thenAnswer((_) async => expectedCatUris);

      // Act
      bloc.add(GetLikedCatsEvent());

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            CatsViewLoading(),
            CatsViewContentReady(expectedCatUris),
          ],
        ),
      );
    });

    test('when a getDislikedCatsEvent occurs, the loading start and after a list of liked cat uris are returned', () {
      // Arrange
      List<CatUriModel> expectedCatUris = [CatUriModel(uri: "dönci", timestamp: Timestamp.now())];
      when(mockInteractor.getDislikedCatUris()).thenAnswer((_) async => expectedCatUris);

      // Act
      bloc.add(GetDislikedCatsEvent());

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            CatsViewLoading(),
            CatsViewContentReady(expectedCatUris),
          ],
        ),
      );
    });

    test('when a getLikedCatsEvent occurs, the loading start and after a state representing an empty list is returned', () {
      // Arrange
      List<CatUriModel> expectedCatUris = [];
      when(mockInteractor.getLikedCatUris()).thenAnswer((_) async => expectedCatUris);

      // Act
      bloc.add(GetLikedCatsEvent());

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            CatsViewLoading(),
            CatsViewEmpty()
          ],
        ),
      );
    });

    test('when a getDislikedCatsEvent occurs, the loading start and after a state representing an empty list is returned', () {
      // Arrange
      List<CatUriModel> expectedCatUris = [];
      when(mockInteractor.getDislikedCatUris()).thenAnswer((_) async => expectedCatUris);

      // Act
      bloc.add(GetDislikedCatsEvent());

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            CatsViewLoading(),
            CatsViewEmpty()
          ],
        ),
      );
    });
  });

  group("Error Cases", () {
    test('when a GetLikedEvent occurs, the loading start and after an error is returned', () {
      // Arrange
      String expectedString = 'error';
      when(mockInteractor.getLikedCatUris()).thenThrow(expectedString);

      // Act
      bloc.add(GetLikedCatsEvent());

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            CatsViewLoading(),
            // TODO: figure out what goes into CatsViewLoading(:String)
          ],
        ),
      );
    });

    test('when a GetDisikedEvent occurs, the loading start and after an error is returned', () {
      // Arrange
      String expectedString = 'error';
      when(mockInteractor.getDislikedCatUris()).thenThrow(expectedString);

      // Act
      bloc.add(GetDislikedCatsEvent());

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            CatsViewLoading(),
            // TODO: figure out what goes into CatsViewLoading(:String)
          ],
        ),
      );
    });
  });
}
