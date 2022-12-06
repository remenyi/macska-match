import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macska_match/pages/home_page/random_cat_bloc.dart';
import 'package:macska_match/widgets/missing_content.dart';
import 'package:macska_match/widgets/popup.dart';
import 'package:macska_match/widgets/retry_button.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CatPicture extends StatelessWidget {
  const CatPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
