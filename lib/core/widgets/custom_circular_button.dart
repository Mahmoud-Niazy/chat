import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final IconData icon;

  final Color backgroundColor;

  final Color iconColor;
  final void Function()? onPressed;
  final double height ;

  const CustomCircularButton({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
    required this.height,

  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: backgroundColor,
      shape: const CircleBorder(),
      height: height,
      minWidth: 0,
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
