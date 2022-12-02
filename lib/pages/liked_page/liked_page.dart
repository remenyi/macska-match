import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/helpers/empty_content.dart';
import 'package:macska_match/helpers/missing_content.dart';
import 'package:macska_match/helpers/popup.dart';
import 'package:macska_match/helpers/retry_button.dart';
import 'package:macska_match/pages/liked_page/liked_cats_bloc.dart';
import 'package:macska_match/widgets/cat_list.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
    final List<Cat> cats = [];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: const Text(
            'Liked cats',
            style: TextStyle(
              color: Color.fromRGBO(255, 111, 127, 1),
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => injector<LikedCatsBloc>(),
          child: Builder(builder: (context) {
            return BlocConsumer<LikedCatsBloc, LikedCatsState>(
              listener: (context, state) {
                if (state is LikedCatsError) {
                  context.showErrorPopup(
                    description: "Failed to load liked cats!",
                  );
                }
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case LikedCatsInitial:
                    BlocProvider.of<LikedCatsBloc>(context).add(GetLikedCatsEvent());
                    return Container();
                  case LikedCatsLoading:
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case LikedCatsEmpty:
                    return Expanded(
                      child: Center(
                        child: showEmptyContent(
                          'There are no liked cats!',
                          SvgPicture.asset('assets/like.svg'),
                        ),
                      ),
                    );
                  case LikedCatContentReady:
                    final cat = (state as LikedCatContentReady).cat;
                    cats.insert(0, cat);
                    listKey.currentState?.insertItem(0);
                    return CatList(
                      listKey: listKey,
                      catList: cats,
                    );
                  default:
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          showMissingContent('Could not load liked cats!'),
                          const SizedBox(
                            height: 20,
                          ),
                          retryButton(() => BlocProvider.of<LikedCatsBloc>(context).add(GetLikedCatsEvent())),
                        ],
                      ),
                    );
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
