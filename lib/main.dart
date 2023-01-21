import 'package:flutter/material.dart';
import 'package:rice_music_sharing/screen/group_and_profile_screen.dart';
import 'themes/themes.dart';
import 'widgets/my_navigation_bar.dart';

void main() {
  runApp(const MyApp());
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
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
