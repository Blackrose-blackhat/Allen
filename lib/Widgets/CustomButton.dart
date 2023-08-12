import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Text label;
  final Icon icon;
  final Function() onPressed;
  const CustomButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}
