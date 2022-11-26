import 'package:flutter/material.dart';

Widget retryButton(Function() onPressed) {
  final color = Color.fromRGBO(142, 142, 142, 1);

  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      side: BorderSide(
        color: color,
        width: 2,
      ),
      padding: EdgeInsets.all(10),
      foregroundColor: color,
    ),
    onPressed: onPressed,
    child: Text(
      'Retry',
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}
