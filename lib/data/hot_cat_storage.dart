import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';

class HotCatStorage {
  final Map<CatUriModel, Cat> _cats = <CatUriModel, Cat>{};

  Cat? getCat(CatUriModel catUri) => _cats[catUri];

  void saveCat(CatUriModel catUri, Cat cat) => _cats[catUri] = cat;
}