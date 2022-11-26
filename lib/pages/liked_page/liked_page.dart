import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/helpers/empty_content.dart';
import 'package:macska_match/helpers/missing_content.dart';
import 'package:macska_match/helpers/popup.dart';
import 'package:macska_match/helpers/retry_button.dart';
import 'package:macska_match/pages/liked_page/liked_cats_bloc.dart';

class LikedPage extends StatelessWidget {
  LikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
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
          child: BlocConsumer<LikedCatsBloc, LikedCatsState>(
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
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case LikedCatsContentReady:
                  final cats = (state as LikedCatsContentReady).cats;
                  if (cats.isEmpty)
                    return Expanded(
                      child: Center(
                        child: showEmptyContent(
                          'There are no liked cats!',
                        ),
                      ),
                    );
                  return _buildLikedCatsList((state as LikedCatsContentReady).cats);
                default:
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        showMissingContent('Could not load liked cats!'),
                        SizedBox(
                          height: 20,
                        ),
                        retryButton(() => BlocProvider.of<LikedCatsBloc>(context).add(GetLikedCatsEvent())),
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

  Widget _buildLikedCatsList(List<Cat> cats) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cats.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    child: Image.memory(cats[index].picture,
                        // width: 300,
                        height: 200,
                        fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
