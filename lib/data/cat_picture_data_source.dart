import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../domain/model/cat.dart';
import '../domain/model/cat_uri_model.dart';
import 'cat_picture_hot_data_source.dart';

class CatPictureDataSource {
  static const _likedCatPath = 'liked_cats/';
  static const _dislikedCatPath = 'disliked_cats/';
  static const _maxSize = 1024 * 1024 * 100; // 10 megabytes, to download large files
  final CatPictureHotDataSource _hotCatStorage;

  CatPictureDataSource(this._hotCatStorage);

  Future<CatUriModel> saveToLiked(Cat cat) async => await _saveCat(cat, '$_likedCatPath${cat.picture.hashCode}');

  Future<CatUriModel> saveToDisliked(Cat cat) async => await _saveCat(cat, '$_dislikedCatPath${cat.picture.hashCode}');

  Future<Cat> getCat(CatUriModel catUriModel) async {
    final hotCat = _hotCatStorage.getCat(catUriModel);
    if (hotCat != null) {
      return hotCat;
    }

    final catRef = FirebaseStorage.instance.refFromURL(catUriModel.uri);
    final data = await catRef.getData(_maxSize);

    if (data == null) throw NullThrownError();

    final coldCat = Cat(picture: data);
    _hotCatStorage.saveCat(catUriModel, coldCat);
    return coldCat;
  }

  Future deleteCat(CatUriModel catUri) async {
    final catRef = FirebaseStorage.instance.refFromURL(catUri.uri);
    _hotCatStorage.deleteCat(catUri);
    await catRef.delete();
  }

  Future<CatUriModel> _saveCat(Cat cat, String location) async {
    final catRef = FirebaseStorage.instance.ref(location);
    await catRef.putData(
      cat.picture,
    );
    final uri = await catRef.getDownloadURL();
    final catUriModel = CatUriModel(uri: uri, timestamp: Timestamp.now());
    _hotCatStorage.saveCat(catUriModel, cat);
    return catUriModel;
  }
}
