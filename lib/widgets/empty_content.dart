import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String message;
  final Widget icon;

  const EmptyContent({Key? key, required this.message, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

