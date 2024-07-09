import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IconButtonArrowBack extends StatelessWidget {
  const IconButtonArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
      ),
    );
  }
}
