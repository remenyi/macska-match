import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/ui/pages/home_page/widgets/swipe_bloc.dart';
import 'package:macska_match/ui/popups/popup.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../../domain/model/cat.dart';
import '../../../widgets/missing_content.dart';
import '../../../widgets/retry_button.dart';
import '../random_cat_bloc.dart';
import 'like_dislike_button.dart';
import 'like_dislike_overlay.dart';

class SwipeableCard extends StatefulWidget {
  const SwipeableCard({Key? key}) : super(key: key);

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard> {
  late final SwipableStackController controller;
  final _loadedCats = <int, Cat>{};

  @override
  void initState() {
    super.initState();
    controller = SwipableStackController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SwipeBloc>(),
      child: BlocConsumer<SwipeBloc, SwipeState>(
        listener: (context, state) {
          final l10n = L10n.of(context)!;
          switch (state.runtimeType) {
            case GetRandomCatError:
              final errorMessage = (state as GetRandomCatError).errorMessage;
              context.showErrorPopup(
                description: l10n.catLoadError,
                details: errorMessage,
              );
              break;
          }
        },
        builder: (context, state) {
          return SwipableStack(
            itemCount: null,
            dragStartDuration: const Duration(milliseconds: 1000),
            controller: controller,
            overlayBuilder: (context, properties) {
              final opacity = min(properties.swipeProgress, 1.0);
              return Opacity(
                opacity:
                properties.direction == SwipeDirection.right || properties.direction == SwipeDirection.left
                    ? opacity
                    : 0,
                child: LikeDislikeOverlay(isLeft: properties.direction == SwipeDirection.left),
              );
            },
            onSwipeCompleted: (index, direction) {
              switch (direction) {
                case SwipeDirection.right:
                  if (_loadedCats.containsKey(index)) {
                    BlocProvider.of<SwipeBloc>(context).add(RightSwipeEvent(_loadedCats[index]!));
                  }
                  break;
                case SwipeDirection.left:
                  if (_loadedCats.containsKey(index)) {
                    BlocProvider.of<SwipeBloc>(context).add(LeftSwipeEvent(_loadedCats[index]!));
                  }
                  break;
                case SwipeDirection.up:
                  break;
                case SwipeDirection.down:
                  break;
              }
            },
            detectableSwipeDirections: const {SwipeDirection.left, SwipeDirection.right},
            allowVerticalSwipe: true,
            builder: (context, properties) {
              return BlocProvider(
                create: (context) => injector<RandomCatBloc>(),
                child: Builder(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          elevation: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                child: SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.4,
                                  child: _buildCatPicture(properties.index),
                                ),
                              ),
                              const Spacer(),
                              _buildButtons(properties.stackIndex),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildButtons(int index) {
    return BlocConsumer<RandomCatBloc, RandomCatState>(
      listener: (context, state) {
        final l10n = L10n.of(context)!;

        switch (state.runtimeType) {
          case LikeRandomCatError:
            final errorMessage = (state as LikeRandomCatError).errorMessage;
            context.showErrorPopup(
              description: l10n.failedLike,
              details: errorMessage,
            );
            BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
            break;
          case DislikeRandomCatError:
            final errorMessage = (state as DislikeRandomCatError).errorMessage;
            context.showErrorPopup(
              description: l10n.failedDislike,
              details: errorMessage,
            );
            BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
            break;
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            const Spacer(flex: 10),
            LikeDislikeButton(
              color: const Color.fromRGBO(255, 129, 166, 1),
              icon: Icons.favorite,
              onPressed: state is RandomCatContentReady
                  ? () async {
                BlocProvider.of<RandomCatBloc>(context).add(LikeRandomCatEvent(state.cat));
                controller.next(
                  swipeDirection: SwipeDirection.right,
                  shouldCallCompletionCallback: false,
                  duration: const Duration(milliseconds: 500),
                );
                BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
              }
                  : () {},
            ),
            const Spacer(flex: 1),
            LikeDislikeButton(
              color: const Color.fromRGBO(142, 142, 142, 1),
              icon: Icons.close,
              onPressed: state is RandomCatContentReady
                  ? () async {
                BlocProvider.of<RandomCatBloc>(context).add(DislikeRandomCatEvent(state.cat));
                controller.next(
                  swipeDirection: SwipeDirection.left,
                  shouldCallCompletionCallback: false,
                  duration: const Duration(milliseconds: 500),
                );
                BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
              }
                  : () {},
            ),
            const Spacer(flex: 10),
          ],
        );
      },
    );
  }

  Widget _buildCatPicture(int index) {
    return BlocConsumer<RandomCatBloc, RandomCatState>(
      listener: (context, state) {
        final l10n = L10n.of(context)!;

        switch (state.runtimeType) {
          case GetRandomCatError:
            final errorMessage = (state as GetRandomCatError).errorMessage;
            context.showErrorPopup(
              description: l10n.catLoadError,
              details: errorMessage,
            );
            break;
          case RandomCatContentReady:
            final cat = (state as RandomCatContentReady).cat;
            _loadedCats[index] = cat;
        }
      },
      builder: (context, state) {
        final l10n = L10n.of(context)!;

        switch (state.runtimeType) {
          case RandomCatLoading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RandomCatInitial:
            BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
            return Container();
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
                MissingContent(message: l10n.catLoadError),
                const SizedBox(
                  height: 20,
                ),
                RetryButton(onPressed: () => BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent())),
              ],
            );
        }
      },
    );
  }
}
