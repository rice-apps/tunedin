import '../data/models/post_model.dart';
import '../http/api_client.dart';

class PostRepository {
  final ApiClient postApiClient;

  PostRepository({required this.postApiClient});

  Future<List<PostModel>> fetchPosts() async {
    return await postApiClient.http.get('/posts').then((response) {
      return (response.data as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
    });
  }

  Future<PostModel> createPost(String? bodyText, String? musicUrl) async {
    return await postApiClient.http.post('/posts', data: {
      'bodyText': bodyText,
      'musicUrl': musicUrl,
    }).then((response) {
      return PostModel.fromJson(response.data);
    });
  }

  Future<PostModel> likePost(String? postId) async {
    return await postApiClient.http
        .post('/posts/$postId/like')
        .then((response) {
      return PostModel.fromJson(response.data);
    });
  }

  Future<PostModel> unlikePost(String? postId) async {
    return await postApiClient.http
        .post('/posts/$postId/unlike')
        .then((response) {
      return PostModel.fromJson(response.data);
    });
  }

  Future<PostModel> deletePost(String? postId) async {
    return await postApiClient.http.delete('/posts/$postId').then((response) {
      return PostModel.fromJson(response.data);
    });
  }
}
