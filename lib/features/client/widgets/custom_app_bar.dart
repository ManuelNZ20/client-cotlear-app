import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              const Icon(Icons.stacked_bar_chart_rounded),
              const SizedBox(width: 10),
              Text(
                // 'Hola, ${ref.watch(userProvider).name}',
                'Hola',
                style: titleStyle,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context.push('/user'),
                icon: const Icon(Icons.person_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
