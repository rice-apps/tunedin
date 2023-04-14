import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/post_provider.dart';

class PostController {
  final WidgetRef _ref;

  PostController(this._ref);

  Future<void> likePost() async {
    final postId = _ref.read(postStateProvider).id;
    _ref.read(postRepositoryProvider).likePost(postId).then((value) => _ref
        .read(postStateProvider.notifier)
        .setState(_ref.read(postStateProvider).copyWith(
            numLikes: value.numLikes! + 1))); // replace this to use likedBy
  }

  Future<void> deletePost() async {
    final postId = _ref.read(postStateProvider).id;
    _ref.read(postRepositoryProvider).deletePost(postId).then((value) =>
        _ref.read(postStateProvider.notifier).status = PostStatus.deleted);
  }
}
