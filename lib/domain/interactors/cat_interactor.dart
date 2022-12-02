import 'package:macska_match/data/caas_data_source.dart';
import 'package:macska_match/data/cat_storage.dart';
import 'package:macska_match/data/cat_uri_storage.dart';
import 'package:macska_match/domain/model/cat.dart';

class CatInteractor {
  final CaasDataSource _caasDataSource;
  final CatStorage _catStorage;
  final CatUriStorage _catUriStorage;

  CatInteractor(this._caasDataSource, this._catStorage, this._catUriStorage);

  Future<Cat> getRandomCat() async {
    return _caasDataSource.getRandomCat();
  }

  Future likeCat(Cat cat) async {
    final uri = await _catStorage.saveToLiked(cat);
    await _catUriStorage.saveLikedCatUri(uri);
  }

  Future dislikeCat(Cat cat) async {
    final uri = await _catStorage.saveToDisliked(cat);
    await _catUriStorage.saveDislikedCatUri(uri);
  }

  Future<bool> isLikedCatsEmpty() async {
    return _catUriStorage.isLikedCatsEmpty();
  }

  Future<bool> isDislikedCatsEmpty() async {
    return _catUriStorage.isDislikedCatsEmpty();
  }

  Stream<Cat> getLikedCats() async* {
    final uris = _catUriStorage.getLikedCatUris();
    yield* uris.asyncMap<Cat>((e) async => await _catStorage.getCat(e));
  }

  Stream<Cat> getDislikedCats() async* {
    final uris = _catUriStorage.getDislikedCatUris();
    yield* uris.asyncMap<Cat>((e) async => await _catStorage.getCat(e));
  }
}
