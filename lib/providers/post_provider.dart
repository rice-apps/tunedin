import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_music_sharing/providers/http_provider.dart';

import '../data/models/post_model.dart';
import '../repository/post_repository.dart';

final postRepositoryProvider = Provider<PostRepository>(
    (ref) => PostRepository(postApiClient: ref.read(httpProvider)));
final postListProvider = FutureProvider.autoDispose<List<PostModel>>(
    (ref) => ref.read(postRepositoryProvider).fetchPosts());

enum PostStatus { loading, loaded, error, deleted }

class PostState extends StateNotifier<PostModel> {
  PostStatus status = PostStatus.loading;
  PostState(PostModel model) : super(model);

  setState(PostModel model) {
    status = PostStatus.loaded;
    super.state = model;
  }
}

final postStateProvider =
    StateNotifierProvider.autoDispose<PostState, PostModel>(
        throw UnimplementedError());
