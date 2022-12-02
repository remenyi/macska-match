import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/pages/home_page/random_cat_bloc.dart';
import 'package:macska_match/pages/home_page/widgets/like_dislike_button.dart';
import 'package:macska_match/widgets/missing_content.dart';
import 'package:macska_match/widgets/popup.dart';
import 'package:macska_match/widgets/retry_button.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SwipableStackController controller;

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
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 30,
            child: SwipableStack(
              dragStartDuration: const Duration(milliseconds: 1000),
              controller: controller,
              overlayBuilder: (context, properties) {
                final opacity = min(properties.swipeProgress, 1.0);
                return Opacity(
                  opacity: properties.direction == SwipeDirection.right || properties.direction == SwipeDirection.left
                      ? opacity
                      : 0,
                  child: _buildOverlay(properties.direction == SwipeDirection.left),
                );
              },
              onSwipeCompleted: (index, direction) {
                switch (direction) {
                  case SwipeDirection.right:
                    break;
                  case SwipeDirection.left:
                    break;
                  case SwipeDirection.up:
                    break;
                  case SwipeDirection.down:
                    break;
                }
              },
              allowVerticalSwipe: true,
              builder: (context, properties) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocProvider(
                    create: (context) => injector<RandomCatBloc>(),
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
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: _buildCardImage(),
                            ),
                          ),
                          const Spacer(),
                          _buildButtons(),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: const Text(
                'To like a picture of a cat click on the heart icon, or swipe right',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(142, 142, 142, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildCardImage() {
    return BlocConsumer<RandomCatBloc, RandomCatState>(listener: (context, state) {
      switch (state.runtimeType) {
        case GetRandomCatError:
          final errorMessage = (state as GetRandomCatError).errorMessage;
          context.showErrorPopup(
            description: "Failed to load a new cat!",
            details: errorMessage,
          );
          // BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
          break;
      }
    }, builder: (context, state) {
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
              showMissingContent('Could not load new cat!'),
              const SizedBox(
                height: 20,
              ),
              retryButton(() => BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent())),
            ],
          );
      }
    });
  }

  Widget _buildButtons() {
    return BlocConsumer<RandomCatBloc, RandomCatState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case LikeRandomCatError:
            final errorMessage = (state as LikeRandomCatError).errorMessage;
            context.showErrorPopup(
              description: "Failed to like the cat!",
              details: errorMessage,
            );
            BlocProvider.of<RandomCatBloc>(context).add(GetRandomCatEvent());
            break;
          case DislikeRandomCatError:
            final errorMessage = (state as DislikeRandomCatError).errorMessage;
            context.showErrorPopup(
              description: "Failed to dislike the cat!",
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
                  ? () {
                      BlocProvider.of<RandomCatBloc>(context).add(LikeRandomCatEvent(state.cat));
                      controller.next(
                        swipeDirection: SwipeDirection.right,
                        duration: const Duration(milliseconds: 500),
                      );
                    }
                  : () {},
            ),
            const Spacer(flex: 1),
            LikeDislikeButton(
              color: const Color.fromRGBO(142, 142, 142, 1),
              icon: Icons.close,
              onPressed: state is RandomCatContentReady
                  ? () {
                      BlocProvider.of<RandomCatBloc>(context).add(DislikeRandomCatEvent(state.cat));
                      controller.next(
                        swipeDirection: SwipeDirection.left,
                        duration: const Duration(milliseconds: 500),
                      );
                    }
                  : () {},
            ),
            const Spacer(flex: 10),
          ],
        );
      },
    );
  }

  Widget _buildOverlay(bool isLeft) {
    final text = isLeft ? 'Disliked' : 'Liked';
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: isLeft ? Alignment.topRight : Alignment.topLeft,
        child: Transform.rotate(
          angle: isLeft ? pi / 6 : -pi / 6,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              border: Border.all(
                color: isLeft ? Colors.red : Colors.green,
                width: 3,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(text,
                style: TextStyle(
                  color: isLeft ? Colors.red : Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
    );
  }
}
