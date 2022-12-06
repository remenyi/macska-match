import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/model/cat_uri_model.dart';

class CatUriDataSource {
  static const _likedCollection = 'liked_cats';
  static const _dislikedCollection = 'disliked_cats';

  Future saveLikedCatUri(CatUriModel uri) async => await _saveCatUri(uri, _likedCollection);

  Future saveDislikedCatUri(CatUriModel uri) async => await _saveCatUri(uri, _dislikedCollection);

  Future<Iterable<CatUriModel>> getLikedCatUris() => _getCatUris(_likedCollection);

  Future<Iterable<CatUriModel>> getDislikedCatUris() => _getCatUris(_dislikedCollection);

  Future deleteCatUri(CatUriModel catUri) async {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: true);

    final likedCatDocs = await db.collection(_likedCollection).where('uri', isEqualTo: catUri.uri).get();
    if (likedCatDocs.docs.isNotEmpty) {
      await db.collection(_likedCollection).doc(likedCatDocs.docs.first.id).delete();
    }

    final dislikedCatDocs = await db.collection(_dislikedCollection).where('uri', isEqualTo: catUri.uri).get();
    if (dislikedCatDocs.docs.isNotEmpty) {
      await db.collection(_dislikedCollection).doc(dislikedCatDocs.docs.first.id).delete();
    }
  }

  Future _saveCatUri(CatUriModel uriModel, String collection) async {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: true);
    await db.collection(collection).add(uriModel.toMap()).timeout(const Duration(seconds: 5));
  }

  Future<Iterable<CatUriModel>> _getCatUris(String collection) async {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: true);

    final results = await db.collection(collection).orderBy('timestamp', descending: true).get();

    return results.docs.map((doc) => CatUriModel(uri: doc['uri'], timestamp: doc['timestamp']));
  }
}
