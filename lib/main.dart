import 'package:flutter/material.dart';
import 'widgets/my_navigation_bar.dart';
import 'widgets/create_post_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to TunedIn',
      home: Scaffold(
        bottomNavigationBar: const MyNavigationBar(),
        appBar: AppBar(
          title: const Text('Welcome to TunedIn'),
        ),
        body: const Center(
          // child: Text('Hello World'),
          child: CreatePostWidget(),
        ),
      ),
    );
  }
}
