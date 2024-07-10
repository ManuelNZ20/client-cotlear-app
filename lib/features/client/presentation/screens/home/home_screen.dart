import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
    required this.childView,
  });
  final Widget childView;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
