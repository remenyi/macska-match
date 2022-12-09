import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:macska_match/ui/pages/cats_view_page/cats_view_bloc.dart';
import 'package:macska_match/ui/popups/popup.dart';

import '../../../../di/di.dart';
import '../../../../domain/model/cat_uri_model.dart';
import '../../../curves/custom_popup_curve.dart';
import '../../../widgets/retry_button.dart';
import 'cat_list_element_bloc.dart';

class CatList extends StatefulWidget {
  final List<CatUriModel> catUriList;
  final Function() onEmptyEvent;

  const CatList({super.key, required this.catUriList, required this.onEmptyEvent});

  @override
  State<CatList> createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  late final List<CatUriModel> _catUriList;

  @override
  void initState() {
    super.initState();
    _catUriList = widget.catUriList;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _catUriList.length,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        return BlocProvider(
          key: ValueKey<CatUriModel>(_catUriList[index]),
          create: (context) => injector<CatListElementBloc>(),
          child: BlocListener<CatListElementBloc, CatListElementState>(
            listener: (context, state) {
              switch (state.runtimeType) {
                case CatListElementDeleteError:
                  final details = (state as CatListElementDeleteError).error;
                  context.showErrorPopup(
                    description: l10n.deleteError,
                    details: details,
                  );
                  break;
              }
            },
            child: CatCard(
              key: Key(index.toString()),
              catUriList: _catUriList,
              index: index,
              parentSetState: setState,
            ),
          ),
        );
      },
    );
  }
}

class CatCard extends StatefulWidget {
  final List<CatUriModel> catUriList;
  final int index;
  // This is an antipattern, however this was the only solution I could find.
  // The Dismissible widget needs to delete its item immediately from its list. This means
  // that firing a bloc event is insufficient in this case, we have to delete the CatUriModel in place.
  // Because the CatUriModel list gets shorter, we need to refresh the parent page.
  final Function(Function()) parentSetState;

  const CatCard({Key? key, required this.catUriList, required this.index, required this.parentSetState})
      : super(key: key);

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 4;
    final heightExpanded = MediaQuery.of(context).size.height / 2;
    return GestureDetector(
      onTap: () => setState(() {
        isExpanded = !isExpanded;
      }),
      child: Dismissible(
        key: ValueKey<CatUriModel>(widget.catUriList[widget.index]),
        onDismissed: (direction) {
          BlocProvider.of<CatListElementBloc>(context)
              .add(DeleteCatListElementEvent(widget.catUriList[widget.index], widget.index));
          if (widget.catUriList.length == 1) {
            BlocProvider.of<CatsViewBloc>(context).add(CatListEmptiedEvent());
          }
          widget.parentSetState(() {
            widget.catUriList.removeAt(widget.index);
          });
        },
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
                        final l10n = L10n.of(context)!;

                        switch (state.runtimeType) {
                          case CatListElementInitial:
                            BlocProvider.of<CatListElementBloc>(context)
                                .add(GetCatListElementEvent(widget.catUriList[widget.index]));
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
                                  Text(l10n.catMissing),
                                  const Spacer(),
                                  RetryButton(
                                    onPressed: () => BlocProvider.of<CatListElementBloc>(context)
                                        .add(GetCatListElementEvent(widget.catUriList[widget.index])),
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
