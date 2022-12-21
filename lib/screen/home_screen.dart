import 'package:flutter/material.dart';

import '../widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ListView.builder(itemBuilder: (context, index) => const PostWidget()),
    );
  }
}
