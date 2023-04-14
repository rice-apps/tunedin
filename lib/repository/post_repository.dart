import '../data/models/post_model.dart';
import '../http/api_client.dart';

class PostRepository {
  final ApiClient postApiClient;

  PostRepository({required this.postApiClient});

  Future<List<PostModel>> fetchPosts() async {
    return await postApiClient.http.then((dio) {
      return dio.get('/users/user/timeline').then((response) {
        return (response.data as List)
            .map((post) => PostModel.fromJson(post))
            .toList();
      });
    });
  }

  Future<PostModel> createPost(String? bodyText, String? musicUrl) async {
    return await postApiClient.http.then((dio) => dio.post('/posts', data: {
          'bodyText': bodyText,
          'musicUrl': musicUrl,
        }).then((response) {
          return PostModel.fromJson(response.data);
        }));
  }

  Future<PostModel> likePost(String? postId) async {
    return await postApiClient.http
        .then((dio) => dio.post('/posts/$postId/like').then((response) {
              return PostModel.fromJson(response.data);
            }));
  }

  Future<PostModel> unlikePost(String? postId) async {
    return await postApiClient.http
        .then((dio) => dio.post('/posts/$postId/unlike').then((response) {
              return PostModel.fromJson(response.data);
            }));
  }

  Future<PostModel> deletePost(String? postId) async {
    return await postApiClient.http
        .then((dio) => dio.delete('/posts/$postId').then((response) {
              return PostModel.fromJson(response.data);
            }));
  }
}
