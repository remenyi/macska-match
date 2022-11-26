import 'package:macska_match/data/caas_data_source.dart';
import 'package:macska_match/domain/model/cat.dart';

class CatInteractor {
  final CaasDataSource caasDataSource;

  CatInteractor(this.caasDataSource);

  Future<Cat> getRandomCat() async {
    return caasDataSource.getRandomCat();
  }

  Future likeCat(Cat cat) async {}

  Future dislikeCat(Cat cat) async {}

  Future<List<Cat>> getLikedCats() async {
    await Future.delayed(Duration(seconds: 3));
    throw Exception('cica');
    return <Cat>[];
  }

  Future<List<Cat>> getDislikedCats() async {
    return <Cat>[];
  }
}
