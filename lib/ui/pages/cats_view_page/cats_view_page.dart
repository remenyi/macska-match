import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:macska_match/ui/pages/cats_view_page/widgets/cat_list.dart';
import 'package:macska_match/ui/popups/popup.dart';

import '../../../di/di.dart';
import '../../widgets/empty_content.dart';
import '../../widgets/missing_content.dart';
import '../../widgets/retry_button.dart';
import 'cats_view_bloc.dart';

class CatsViewPage extends StatelessWidget {
  final CatsViewType catsViewType;

  const CatsViewPage({Key? key, required this.catsViewType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            catsViewType == CatsViewType.disliked ? l10n.dislikedCats : l10n.likedCats,
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
                  description:
                      catsViewType == CatsViewType.disliked ? l10n.errorLoadingDisliked : l10n.errorLoadingLiked,
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
                                  message: l10n.noDisliked,
                                  icon: SvgPicture.asset('assets/dislike.svg'),
                                )
                              : EmptyContent(
                                  message: l10n.noLiked,
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
                                ? l10n.errorLoadingDisliked
                                : l10n.errorLoadingLiked),
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
