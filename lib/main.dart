import 'package:flutter/material.dart';
import 'package:fyzo_code_challange/router.dart';
import 'package:fyzo_code_challange/utils/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fyzo',
      theme: ref.watch(themeNotifierProvider),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          return loggedInRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}