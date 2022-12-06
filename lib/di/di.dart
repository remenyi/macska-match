import 'package:get_it/get_it.dart';

import '../data/cat_picture_data_source.dart';
import '../data/cat_picture_hot_data_source.dart';
import '../data/cat_uri_data_source.dart';
import '../data/random_cat_data_source.dart';
import '../domain/interactors/cat_interactor.dart';
import '../ui/pages/cats_view_page/cats_view_bloc.dart';
import '../ui/pages/cats_view_page/widgets/cat_list_element_bloc.dart';
import '../ui/pages/home_page/random_cat_bloc.dart';

final injector = GetIt.instance;

void initDependencies() {
  injector.registerSingleton(CatPictureHotDataSource());
  injector.registerSingleton(RandomCatDataSource());
  injector.registerSingleton(CatPictureDataSource(injector<CatPictureHotDataSource>()));
  injector.registerSingleton(CatUriDataSource());

  injector.registerSingletonAsync(() async => CatInteractor(
        injector<RandomCatDataSource>(),
        injector<CatPictureDataSource>(),
        injector<CatUriDataSource>(),
      ));

  injector.registerFactory(() => RandomCatBloc(injector<CatInteractor>()));
  injector.registerFactory(() => CatsViewBloc(injector<CatInteractor>()));
  injector.registerFactory(() => CatListElementBloc(injector<CatInteractor>()));
}
