
import '../domain/model/cat.dart';
import '../domain/model/cat_uri_model.dart';

class CatPictureHotDataSource {
  final Map<CatUriModel, Cat> _cats = <CatUriModel, Cat>{};

  Cat? getCat(CatUriModel catUri) => _cats[catUri];

  void saveCat(CatUriModel catUri, Cat cat) => _cats[catUri] = cat;

  void deleteCat(CatUriModel catUri) => _cats.remove(catUri);
}