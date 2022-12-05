import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macska_match/curves/custom_popup_curve.dart';
import 'package:macska_match/di/di.dart';
import 'package:macska_match/domain/model/cat_uri_model.dart';
import 'package:macska_match/pages/cat_view_page/cats_view_bloc.dart';
import 'package:macska_match/pages/cat_view_page/widgets/cat_list_element_bloc.dart';
import 'package:macska_match/widgets/popup.dart';
import 'package:macska_match/widgets/retry_button.dart';

class CatList extends StatelessWidget {
  final List<CatUriModel> catUriList;
  final Function() onEmptyEvent;

  const CatList({super.key, required this.catUriList, required this.onEmptyEvent});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: catUriList.length,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        return BlocProvider(
          create: (context) => injector<CatListElementBloc>(),
          child: BlocListener<CatListElementBloc, CatListElementState>(
            listener: (context, state) {
              switch (state.runtimeType) {
                case CatListElementDeleted:
                  final index = (state as CatListElementDeleted).index;
                  catUriList.removeAt(index);
                  if (catUriList.isEmpty) {
                    onEmptyEvent();
                  }
                  break;
                case CatListElementDeleteError:
                  final details = (state as CatListElementDeleteError).error;
                  context.showErrorPopup(
                    description: "Could not delete the cat!",
                    details: details,
                  );
                  break;
              }
            },
            child: CatCard(
              catUri: catUriList.elementAt(index),
              index: index,
            ),
          ),
        );
      },
    );
  }
}

class CatCard extends StatefulWidget {
  final CatUriModel catUri;
  final int index;

  const CatCard({Key? key, required this.catUri, required this.index}) : super(key: key);

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 4;
    final heightExpanded = MediaQuery.of(context).size.height / 2;
    return Dismissible(
      key: Key(widget.index.toString()),
      onDismissed: (direction) =>
          BlocProvider.of<CatListElementBloc>(context).add(DeleteCatListElementEvent(widget.catUri, widget.index)),
      child: GestureDetector(
        onTap: () => setState(() {
          isExpanded = !isExpanded;
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: AnimatedSize(
                    curve: const CustomPopInCurve(),
                    duration: const Duration(milliseconds: 500),
                    child: BlocBuilder<CatListElementBloc, CatListElementState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case CatListElementInitial:
                            BlocProvider.of<CatListElementBloc>(context).add(GetCatListElementEvent(widget.catUri));
                            return Container(
                              height: isExpanded ? heightExpanded : height,
                            );
                          case CatListElementLoading:
                            return SizedBox(
                              height: isExpanded ? heightExpanded : height,
                              child: const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          case CatListElementContentReady:
                            final cat = (state as CatListElementContentReady).cat;
                            return Image.memory(
                              cat.picture,
                              height: isExpanded ? heightExpanded : height,
                              fit: BoxFit.cover,
                            );
                          case CatListElementDeleted:
                            return const SizedBox.shrink();
                          default:
                            return SizedBox(
                              height: isExpanded ? heightExpanded : height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(flex: 4),
                                  const Text('Could not load cat!'),
                                  const Spacer(),
                                  RetryButton(
                                    onPressed: () => BlocProvider.of<CatListElementBloc>(context)
                                        .add(GetCatListElementEvent(widget.catUri)),
                                  ),
                                  const Spacer(flex: 4),
                                ],
                              ),
                            );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
