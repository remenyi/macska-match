import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showMissingContent(String? message) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
    Icon(
      Icons.warning_amber_rounded,
      color: Colors.red,
      size: 100,
    ),
    if (message != null) Text(message, style: TextStyle(fontSize: 20))
  ]);
}
