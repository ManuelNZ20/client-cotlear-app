import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.initEnvironment();

  await SupabaseInit.initSupabase();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: AppTheme().themeData(),
      routerConfig: appRouter,
    );
  }
}
