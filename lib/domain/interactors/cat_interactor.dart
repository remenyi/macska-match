
import '../../data/cat_picture_data_source.dart';
import '../../data/cat_uri_data_source.dart';
import '../../data/random_cat_data_source.dart';
import '../model/cat.dart';
import '../model/cat_uri_model.dart';

class CatInteractor {
  final RandomCatDataSource _randomCatDataSource;
  final CatPictureDataSource _catPictureDataSource;
  final CatUriDataSource _catUriDataSource;

  CatInteractor(this._randomCatDataSource, this._catPictureDataSource, this._catUriDataSource);

  Future<Cat> getRandomCat() async {
    return _randomCatDataSource.getRandomCat();
  }

  Future likeCat(Cat cat) async {
    final catUri = await _catPictureDataSource.saveToLiked(cat);
    await _catUriDataSource.saveLikedCatUri(catUri);
  }

  Future dislikeCat(Cat cat) async {
    final catUri = await _catPictureDataSource.saveToDisliked(cat);
    await _catUriDataSource.saveDislikedCatUri(catUri);
  }

  Future<Iterable<CatUriModel>> getLikedCatUris() async => _catUriDataSource.getLikedCatUris();

  Future<Iterable<CatUriModel>> getDislikedCatUris() async => _catUriDataSource.getDislikedCatUris();

  Future<Cat> getCat(CatUriModel catUri) async => await _catPictureDataSource.getCat(catUri);

  Future deleteCat(CatUriModel catUri) async =>
      await Future.wait([_catPictureDataSource.deleteCat(catUri), _catUriDataSource.deleteCatUri(catUri)]);
}
