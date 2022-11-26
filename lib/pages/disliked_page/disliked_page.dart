import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/helpers/empty_content.dart';
import 'package:macska_match/helpers/missing_content.dart';
import 'package:macska_match/helpers/popup.dart';
import 'package:macska_match/helpers/retry_button.dart';

import 'disliked_cats_bloc.dart';

class DislikedPage extends StatelessWidget {
  DislikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
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
                context.showErrorPopup(
                  description: "Failed to load disliked cats!",
                );
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case DislikedCatsInitial:
                  BlocProvider.of<DislikedCatsBloc>(context).add(GetDislikedCatsEvent());
                  return Container();
                case DislikedCatsLoading:
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case DislikedCatsContentReady:
                  final cats = (state as DislikedCatsContentReady).cats;
                  if (cats.isEmpty)
                    return Expanded(
                      child: Center(
                        child: showEmptyContent('There are no disliked cats!'),
                      ),
                    );
                  return _buildDislikedCatsList((state as DislikedCatsContentReady).cats);
                default:
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        showMissingContent('Could not load disliked cats!'),
                        SizedBox(
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

  Widget _buildDislikedCatsList(List<Cat> cats) {
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
