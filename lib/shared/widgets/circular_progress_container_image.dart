import 'package:flutter/material.dart';

class CircularProgressContainer extends StatelessWidget {
  const CircularProgressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: 250,
        child: const Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
        )));
  }
}
