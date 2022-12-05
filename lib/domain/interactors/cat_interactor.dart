import 'package:macska_match/data/caas_data_source.dart';
import 'package:macska_match/data/cat_storage.dart';
import 'package:macska_match/data/cat_uri_storage.dart';
import 'package:macska_match/data/hot_cat_storage.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';

class CatInteractor {
  final CaasDataSource _caasDataSource;
  final CatStorage _catStorage;
  final CatUriStorage _catUriStorage;
  final HotCatStorage _hotCatStorage;

  CatInteractor(this._caasDataSource, this._catStorage, this._catUriStorage, this._hotCatStorage);

  Future<Cat> getRandomCat() async {
    return _caasDataSource.getRandomCat();
  }

  Future likeCat(Cat cat) async {
    final catUri = await _catStorage.saveToLiked(cat);
    await _catUriStorage.saveLikedCatUri(catUri);
    _hotCatStorage.saveCat(catUri, cat);
  }

  Future dislikeCat(Cat cat) async {
    final catUri = await _catStorage.saveToDisliked(cat);
    await _catUriStorage.saveDislikedCatUri(catUri);
    _hotCatStorage.saveCat(catUri, cat);
  }

  Future<Iterable<CatUriModel>> getLikedCatUris() async => _catUriStorage.getLikedCatUris();

  Future<Iterable<CatUriModel>> getDislikedCatUris() async => _catUriStorage.getDislikedCatUris();

  Future<Cat> getCat(CatUriModel catUri) async {
    final hotCat = _hotCatStorage.getCat(catUri);
    if (hotCat != null) {
      return hotCat;
    }
    final coldCat = await _catStorage.getCat(catUri);
    _hotCatStorage.saveCat(catUri, coldCat);
    return coldCat;
  }

  Future deleteCat(CatUriModel catUri) async {
    await Future.wait([_catStorage.deleteCat(catUri), _catUriStorage.deleteCatUri(catUri)]);
  }
}
