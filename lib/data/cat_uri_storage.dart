import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';

class CatUriStorage {
  static const _likedCollection = 'liked_cats';
  static const _dislikedCollection = 'disliked_cats';

  Future saveLikedCatUri(CatUriModel uri) async => await _saveCatUri(uri, _likedCollection);

  Future saveDislikedCatUri(CatUriModel uri) async => await _saveCatUri(uri, _dislikedCollection);

  Future<Iterable<CatUriModel>> getLikedCatUris() => _getCatUris(_likedCollection);

  Future<Iterable<CatUriModel>> getDislikedCatUris() => _getCatUris(_dislikedCollection);

  Future<bool> isDislikedCatsEmpty() => _isCollectionEmpty(_dislikedCollection);

  Future<bool> isLikedCatsEmpty() => _isCollectionEmpty(_likedCollection);

  Future<bool> _isCollectionEmpty(String collection) async {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: false);

    final snapshot = await db.collection(collection).get();

    return snapshot.docs.isEmpty;
  }

  Future _saveCatUri(CatUriModel uriModel, String collection) async {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: false);
    await db.collection(collection).add(uriModel.toMap()).timeout(const Duration(seconds: 5));
  }

  Future<Iterable<CatUriModel>> _getCatUris(String collection) async {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: false);

    final results = await db.collection(collection).orderBy('timestamp', descending: true).get();

    return results.docs.map((doc) => CatUriModel(uri: doc['uri'], timestamp: doc['timestamp']));
  }
}
