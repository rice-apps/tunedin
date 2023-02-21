import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen/home_screen.dart';
import 'themes/themes.dart';
import 'widgets/my_navigation_bar.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.darkTheme,
      title: 'Welcome to TunedIn',
      home: Scaffold(
          bottomNavigationBar: const MyNavigationBar(),
          appBar: AppBar(
            title: const Text('Welcome to TunedIn'),
          ),
          body: const HomeScreen()),
    );
  }
}
