import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class LikeDislikeOverlay extends StatelessWidget {
  final bool isLeft;

  const LikeDislikeOverlay({Key? key, required this.isLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final text = isLeft ? l10n.dislikedOverlay : l10n.likedOverlay;

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
