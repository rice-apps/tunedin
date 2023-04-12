import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/post_model.dart';
import '../providers/post_provider.dart';
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
      body: ListView.builder(
          itemBuilder: (context, index) => ProviderScope(
                overrides: [
                  postStateProvider.overrideWith(
                    (ref) => PostState(
                      PostModel(
                        netID: "123",
                        numLikes: 0,
                        bodyText: "Hello World",
                        musicURL: "https://www.youtube.com/watch?v=QH2-TGUlwu4",
                      ),
                    ),
                  ),
                ],
                child: const PostWidget(),
              )),
    );
  }
}
