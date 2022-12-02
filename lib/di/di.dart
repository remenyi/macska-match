import 'package:get_it/get_it.dart';
import 'package:macska_match/data/caas_data_source.dart';
import 'package:macska_match/data/cat_storage.dart';
import 'package:macska_match/data/cat_uri_storage.dart';
import 'package:macska_match/data/hot_cat_storage.dart';
import 'package:macska_match/domain/interactors/cat_interactor.dart';
import 'package:macska_match/pages/cat_view_page/cats_view_bloc.dart';
import 'package:macska_match/pages/cat_view_page/widgets/cat_list_element_bloc.dart';
import 'package:macska_match/pages/home_page/random_cat_bloc.dart';

final injector = GetIt.instance;

void initDependencies() {
  injector.registerSingleton(CaasDataSource());
  injector.registerSingleton(CatStorage());
  injector.registerSingleton(CatUriStorage());
  injector.registerSingleton(HotCatStorage());

  injector.registerSingletonAsync(() async {
    return CatInteractor(
      injector<CaasDataSource>(),
      injector<CatStorage>(),
      injector<CatUriStorage>(),
      injector<HotCatStorage>(),
    );
  });

  injector.registerFactory(() => RandomCatBloc(injector<CatInteractor>()));
  injector.registerFactory(() => CatsViewBloc(injector<CatInteractor>()));
  injector.registerFactory(() => CatListElementBloc(injector<CatInteractor>()));
}
