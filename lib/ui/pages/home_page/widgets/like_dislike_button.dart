import 'package:flutter/material.dart';

class LikeDislikeButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function() onPressed;

  const LikeDislikeButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        shape: const CircleBorder(),
        side: BorderSide(
          width: 3,
          color: color,
        ),
        padding: const EdgeInsets.all(10),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: color,
        size: 35,
      ),
    );
  }
}
