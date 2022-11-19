import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/my_navigation_bar.dart';

void main() {
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
    return MaterialApp(
      title: 'Welcome to TunedIn',
      home: Scaffold(
        bottomNavigationBar: const MyNavigationBar(),
        appBar: AppBar(
          title: const Text('Welcome to TunedIn'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
