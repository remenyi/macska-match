import 'package:flutter/material.dart';

Widget showEmptyContent(String message, Widget icon) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: icon,
      ),
      Text(
        message,
        style: const TextStyle(
          color: Color.fromRGBO(142, 142, 142, 1),
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    ],
  );
}
