import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:macska_match/domain/model/cat.dart';
import 'package:macska_match/helpers/custom_popup_curve.dart';
import 'package:macska_match/pages/disliked_page/disliked_cats_bloc.dart';

class CatList extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey;
  final List<Cat> catList;

  const CatList({super.key, required this.listKey, required this.catList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
        key: listKey,
        shrinkWrap: true,
        initialItemCount: catList.length,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.ease,
            ),
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: const CustomPopInCurve(),
              ),
              child: ScaleTransition(
                key: UniqueKey(),
                scale: CurvedAnimation(
                  parent: animation,
                  curve: const CustomPopInCurve(),
                ),
                child: CatCard(key: GlobalKey<_CatCardState>(), cat: catList[index], index: index),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CatCard extends StatefulWidget {
  final Cat cat;
  final int index;

  const CatCard({Key? key, required this.cat, required this.index}) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () => setState(() {
          isExpanded = !isExpanded;
        }),
        child: Card(
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
                  child: Image.memory(widget.cat.picture,
                      // width: 300,
                      height: isExpanded ? heightExpanded : height,
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
