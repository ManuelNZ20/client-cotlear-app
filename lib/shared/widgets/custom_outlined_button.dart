import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomOutlinedButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
