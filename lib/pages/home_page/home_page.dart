import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/helpers/missing_content.dart';
import 'package:macska_match/helpers/popup.dart';
import 'package:macska_match/helpers/retry_button.dart';
import 'package:macska_match/pages/home_page/random_cat_bloc.dart';
import 'package:macska_match/services/cat_service.dart';
import 'package:macska_match/widgets/like_dislike_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final catService = GetIt.instance<CatService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: BlocProvider(
              create: (context) => injector<RandomCatBloc>(),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                elevation: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      child: SizedBox(
                        height: 350,
                        child: BlocConsumer<RandomCatBloc, RandomCatState>(
                          listener: (context, state) {
                            switch (state.runtimeType) {
                              case GetRandomCatError:
                                context.showErrorPopup(description: "Failed to load a new cat!");
                                break;
                              case LikeRandomCatError:
                                context.showErrorPopup(description: "Failed to like the cat!");
                                break;
                              case DislikeRandomCatError:
                                context.showErrorPopup(description: "Failed to dislike the cat!");
                                break;
                            }
                          },
                          builder: (context, state) {
                            switch (state.runtimeType) {
                              case RandomCatInitial:
                                BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
                                return Container();
                              case RandomCatLoading:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              case RandomCatContentReady:
                                final cat = (state as RandomCatContentReady).cat;
                                return Image.memory(
                                  cat.picture,
                                  fit: BoxFit.cover,
                                );
                              default:
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    showMissingContent('Could not load new cat!'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    retryButton(() => BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent())),
                                  ],
                                );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: BlocConsumer<RandomCatBloc, RandomCatState>(
                        listener: (context, state) {
                          if (state is LikeRandomCatError) {
                            context.showErrorPopup(
                              description: "Failed to like the cat!",
                            );
                          }
                          if (state is DislikeRandomCatError) {
                            context.showErrorPopup(
                              description: "Failed to dislike the cat!",
                            );
                          }
                        },
                        builder: (context, state) {
                          return Row(
                            children: [
                              Spacer(flex: 10),
                              LikeDislikeButton(
                                color: Color.fromRGBO(255, 129, 166, 1),
                                icon: Icons.favorite,
                                onPressed: state is RandomCatContentReady
                                    ? () => BlocProvider.of<RandomCatBloc>(context).add(LikeRandomCatEvent(state.cat))
                                    : () {},
                              ),
                              Spacer(flex: 1),
                              LikeDislikeButton(
                                color: Color.fromRGBO(142, 142, 142, 1),
                                icon: Icons.close,
                                onPressed: state is RandomCatContentReady
                                    ? () =>
                                        BlocProvider.of<RandomCatBloc>(context).add(DislikeRandomCatEvent(state.cat))
                                    : () {},
                              ),
                              Spacer(flex: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: Text(
              'To like a picture of a cat click on the heart icon, or swipe right',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(142, 142, 142, 1),
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
