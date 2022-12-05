import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  static const color = Color.fromRGBO(142, 142, 142, 1);
  final Function() onPressed;

  const RetryButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
