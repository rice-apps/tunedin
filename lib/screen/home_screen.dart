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
        ),
        body: const PostScroll());
  }
}

class PostScroll extends ConsumerWidget {
  const PostScroll({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postListProvider);
    return posts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
        data: (posts) {
          return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int idx) {
                final PostModel post = posts[idx];
                return ProviderScope(
                  overrides: [
                    postStateProvider.overrideWith((ref) => PostState(post))
                  ],
                  child: const PostWidget(),
                );
              });
        });
  }
}
