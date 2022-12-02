import 'package:flutter/material.dart';

Widget retryButton(Function() onPressed) {
  const color = Color.fromRGBO(142, 142, 142, 1);

  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      side: const BorderSide(
        color: color,
        width: 2,
      ),
      padding: const EdgeInsets.all(10),
      foregroundColor: color,
    ),
    onPressed: onPressed,
    child: const Text(
      'Retry',
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}
