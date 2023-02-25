import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/post_provider.dart';

class PostController {
  final Ref _ref;

  PostController(this._ref);

  Future<void> likePost() async {
    final postId = _ref.read(postStateProvider.notifier).state.netID; // replace this with postID
    _ref.read(postRepositoryProvider).likePost(postId).then((value) =>
      _ref.read(postStateProvider.notifier).state = _ref.read(postStateProvider.notifier).state.copyWith(numLikes: value.numLikes+1)
    );
  }

  Future<void> deletePost() async {
    final postId = _ref.read(postStateProvider.notifier).state.netID; // replace this with postID
    _ref.read(postRepositoryProvider).deletePost(postId).then((value) =>
        _ref.read(postStateProvider.notifier).status = PostStatus.deleted
    );
  }
}