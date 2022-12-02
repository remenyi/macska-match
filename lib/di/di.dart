import 'package:get_it/get_it.dart';
import 'package:macska_match/data/caas_data_source.dart';
import 'package:macska_match/data/cat_storage.dart';
import 'package:macska_match/data/cat_uri_storage.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/pages/disliked_page/disliked_cats_bloc.dart';
import 'package:macska_match/pages/home_page/random_cat_bloc.dart';
import 'package:macska_match/pages/liked_page/liked_cats_bloc.dart';

final injector = GetIt.instance;

void initDependencies() {
  injector.registerSingleton(CaasDataSource());
  injector.registerSingleton(CatStorage());
  injector.registerSingleton(CatUriStorage());

  injector.registerSingletonAsync(() async {
    return CatInteractor(
      injector<CaasDataSource>(),
      injector<CatStorage>(),
      injector<CatUriStorage>(),
    );
  });

  injector.registerFactory(() => RandomCatBloc(injector<CatInteractor>()));
  injector.registerFactory(() => LikedCatsBloc(injector<CatInteractor>()));
  injector.registerFactory(() => DislikedCatsBloc(injector<CatInteractor>()));
}
