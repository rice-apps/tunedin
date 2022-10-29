import 'package:flutter/material.dart';
import 'package:rice_music_sharing/widgets/single_comment.dart';

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
          appBar: AppBar(title: const Text("TunedIn")),
          body: CommentWidget(),
        ));
  }
}
