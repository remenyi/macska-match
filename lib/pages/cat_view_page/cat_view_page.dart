import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/pages/cat_view_page/cats_view_bloc.dart';
import 'package:macska_match/pages/cat_view_page/widgets/cat_list.dart';
import 'package:macska_match/widgets/empty_content.dart';
import 'package:macska_match/widgets/missing_content.dart';
import 'package:macska_match/widgets/popup.dart';
import 'package:macska_match/widgets/retry_button.dart';

class CatsViewPage extends StatelessWidget {
  final CatsViewType catsViewType;

  const CatsViewPage({Key? key, required this.catsViewType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            catsViewType == CatsViewType.disliked ? 'Disliked cats' : 'Liked cats',
            style: const TextStyle(
              color: Color.fromRGBO(255, 111, 127, 1),
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => injector<CatsViewBloc>(),
          child: BlocConsumer<CatsViewBloc, CatsViewState>(
            listener: (context, state) {
              if (state is CatsViewError) {
                final errorMessage = state.errorMessage;
                context.showErrorPopup(
                  description: "Failed to load disliked cats!",
                  details: errorMessage,
                );
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case CatsViewInitial:
                  catsViewType == CatsViewType.disliked
                      ? BlocProvider.of<CatsViewBloc>(context).add(GetDislikedCatsEvent())
                      : BlocProvider.of<CatsViewBloc>(context).add(GetLikedCatsEvent());
                  return Container();
                case CatsViewLoading:
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case CatsViewEmpty:
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 10),
                        Center(
                          child: catsViewType == CatsViewType.disliked
                              ? EmptyContent(
                                  message: 'There are no disliked cats!',
                                  icon: SvgPicture.asset('assets/dislike.svg'),
                                )
                              : EmptyContent(
                                  message: 'There are no liked cats!',
                                  icon: SvgPicture.asset('assets/like.svg'),
                                ),
                        ),
                        const Spacer(),
                        RetryButton(
                            onPressed: () => BlocProvider.of<CatsViewBloc>(context).add(
                                catsViewType == CatsViewType.disliked ? GetDislikedCatsEvent() : GetLikedCatsEvent())),
                        const Spacer(flex: 10),
                      ],
                    ),
                  );
                case CatsViewContentReady:
                  final catUris = (state as CatsViewContentReady).catUris;
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        final event =
                            catsViewType == CatsViewType.disliked ? GetDislikedCatsEvent() : GetLikedCatsEvent();
                        BlocProvider.of<CatsViewBloc>(context).add(event);
                        return Future.delayed(const Duration(seconds: 1));
                      },
                      child: CatList(
                        catUriList: catUris.toList(),
                        onEmptyEvent: () => catsViewType == CatsViewType.disliked
                            ? BlocProvider.of<CatsViewBloc>(context).add(GetDislikedCatsEvent())
                            : BlocProvider.of<CatsViewBloc>(context).add(GetLikedCatsEvent()),
                      ),
                    ),
                  );
                default:
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MissingContent(
                            message: catsViewType == CatsViewType.disliked
                                ? 'Could not load disliked cats!'
                                : 'Could not load liked cats!'),
                        const SizedBox(
                          height: 20,
                        ),
                        RetryButton(
                          onPressed: () => BlocProvider.of<CatsViewBloc>(context).add(
                              catsViewType == CatsViewType.disliked ? GetDislikedCatsEvent() : GetLikedCatsEvent()),
                        ),
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

enum CatsViewType {
  disliked,
  liked,
}
