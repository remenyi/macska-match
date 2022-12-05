import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MissingContent extends StatelessWidget {
  final String? message;

  const MissingContent({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset('assets/missing.svg'),
        ),
        if (message != null) Text(message!, style: const TextStyle(fontSize: 20),),
      ],
    );
  }
}

