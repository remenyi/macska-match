import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';

class CatStorage {
  static const _likedCatPath = 'liked_cats/';
  static const _dislikedCatPath = 'disliked_cats/';
  static const _maxSize = 1024 * 1024 * 100;           // 10 megabytes, allows to download large files

  Future<CatUriModel> saveToLiked(Cat cat) async => await _saveCat(cat, '$_likedCatPath${cat.picture.hashCode}');

  Future<CatUriModel> saveToDisliked(Cat cat) async => await _saveCat(cat, '$_dislikedCatPath${cat.picture.hashCode}');

  Future<Cat> getCat(CatUriModel catUriModel) async {
    final catRef = FirebaseStorage.instance.refFromURL(catUriModel.uri);
    final data = await catRef.getData(_maxSize).timeout(const Duration(seconds: 5));

    if (data == null) throw NullThrownError();

    return Cat(
      picture: data,
    );
  }

  Future<CatUriModel> _saveCat(Cat cat, String location) async {
    final catRef = FirebaseStorage.instance.ref(location);
    await catRef.putData(
      cat.picture,
    ).timeout(const Duration(seconds: 5));
    final uri = await catRef.getDownloadURL();
    return CatUriModel(uri: uri, timestamp: Timestamp.now());
  }
}
