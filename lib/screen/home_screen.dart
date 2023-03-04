import 'package:flutter/material.dart';

import '../widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "TunedIn",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body:
          ListView.builder(itemBuilder: (context, index) => const PostWidget()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.purple,
        extendedTextStyle:
            const TextStyle(fontStyle: FontStyle.normal, fontSize: 17),
        label: const Text('Post'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
