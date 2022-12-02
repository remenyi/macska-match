import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/helpers/empty_content.dart';
import 'package:macska_match/helpers/missing_content.dart';
import 'package:macska_match/helpers/popup.dart';
import 'package:macska_match/helpers/retry_button.dart';
import 'package:macska_match/widgets/cat_list.dart';

import 'disliked_cats_bloc.dart';

class DislikedPage extends StatelessWidget {
  const DislikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
    final List<Cat> cats = [];
    final catList = CatList(
      listKey: listKey,
      catList: cats,
    );

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: const Text(
            'Disliked cats',
            style: TextStyle(
              color: Color.fromRGBO(255, 111, 127, 1),
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => injector<DislikedCatsBloc>(),
          child: BlocConsumer<DislikedCatsBloc, DislikedCatsState>(
            listener: (context, state) {
              if (state is DislikedCatsError) {
                final errorMessage = state.errorMessage;
                context.showErrorPopup(
                  description: "Failed to load disliked cats!",
                  details: errorMessage,
                );
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case DislikedCatsInitial:
                  BlocProvider.of<DislikedCatsBloc>(context).add(GetDislikedCatsEvent());
                  return Container();
                case DislikedCatsLoading:
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case DislikedCatsEmpty:
                  return Expanded(
                    child: Center(
                      child: showEmptyContent(
                        'There are no disliked cats!',
                        SvgPicture.asset('assets/dislike.svg'),
                      ),
                    ),
                  );
                case DislikedCatContentReady:
                  final cat = (state as DislikedCatContentReady).cat;
                  cats.insert(0, cat);
                  listKey.currentState?.insertItem(0);
                  return catList;
                case DislikedCatDeleted:
                  final index = (state as DislikedCatDeleted).index;
                  cats.removeAt(index);
                  listKey.currentState?.removeItem(index, (BuildContext context, Animation<double> animation) {
                    return Container();
                  }, duration: const Duration(milliseconds: 500));
                  return catList;
                default:
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        showMissingContent('Could not load disliked cats!'),
                        const SizedBox(
                          height: 20,
                        ),
                        retryButton(() => BlocProvider.of<DislikedCatsBloc>(context).add(GetDislikedCatsEvent())),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
