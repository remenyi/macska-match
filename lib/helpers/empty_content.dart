import 'package:flutter/material.dart';

Widget showEmptyContent(String message) {
  return Text(
    message,
    style: TextStyle(
      color: Color.fromRGBO(142, 142, 142, 1),
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
  );
}
