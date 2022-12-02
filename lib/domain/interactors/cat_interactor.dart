import 'package:macska_match/data/caas_data_source.dart';
import 'package:macska_match/data/cat_storage.dart';
import 'package:macska_match/data/cat_uri_storage.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';

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

  Future<bool> isLikedCatsEmpty() async => _catUriStorage.isLikedCatsEmpty();

  Future<bool> isDislikedCatsEmpty() async => _catUriStorage.isDislikedCatsEmpty();

  Future<Iterable<CatUriModel>> getLikedCatUris() async => _catUriStorage.getLikedCatUris();

  Future<Iterable<CatUriModel>> getDislikedCatUris() async => _catUriStorage.getDislikedCatUris();

  Future<Cat> getCat(CatUriModel catUriModel) async => _catStorage.getCat(catUriModel);
}
