import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget showMissingContent(String? message) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: SvgPicture.asset('assets/missing.svg'),
    ),
    if (message != null) Text(message, style: const TextStyle(fontSize: 20))
  ]);
}
