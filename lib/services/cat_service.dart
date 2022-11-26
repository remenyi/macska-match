import 'package:flutter/services.dart';
import 'package:http/http.dart';

class CatService {
  final _likedCats = <Uint8List>[];
  final _dislikedCats = <Uint8List>[];

  Future<Uint8List> getRandomCat() async {
    final response = await get(Uri.parse('https://cataas.com/cat'));
    return response.bodyBytes;
  }

  void addToLiked(Uint8List cat) => _likedCats.add(cat);

  void addToDisliked(Uint8List cat) => _dislikedCats.add(cat);

  List<Uint8List> get likedCats => _likedCats;

  List<Uint8List> get dislikedCats => _dislikedCats;
}
