import 'package:flutter/material.dart';
import 'widgets/MyNavigationBar.dart';

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
        bottomNavigationBar: MyNavigationBar(),
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
