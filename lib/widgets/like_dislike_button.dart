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
        shape: CircleBorder(),
        side: BorderSide(
          width: 3,
          color: color,
        ),
        padding: EdgeInsets.all(12),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: color,
        size: 40,
      ),
    );
  }
}
